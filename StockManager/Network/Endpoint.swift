//
//  Endpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import Alamofire
import RxSwift

struct ImageUpload {
    let data: Data
    let fieldName: String
    let fileName: String
    let mimeType: String

    init(data: Data, fieldName: String, fileName: String = "\(UUID().uuidString).jpg", mimeType: String = "image/jpg") {
        self.data = data
        self.fieldName = fieldName
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

protocol Endpoint {
    associatedtype Request: Codable
    associatedtype Response: BaseAPIResponse

    var urlMethod: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var urlParams: [String: String]? { get }

    func getUrl() -> String
}

extension Endpoint {

    func getUrl() -> String {
        let url = APIConstant.baseUrl
        guard var urlComp = URLComponents(string: url) else { return url }
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "method", value: self.urlMethod))
        queryItems.append(URLQueryItem(name: "version", value: "\(APIConstant.apiVersion)"))

        for (key, value) in urlParams ?? [:] {
            let query = URLQueryItem(name: key, value: value)
            queryItems.append(query)
        }

        urlComp.queryItems = queryItems
        return urlComp.url?.absoluteString ?? url
    }

    func request(parameters: Request? = nil, imageUpload: [ImageUpload]? = nil) -> Observable<Response> {
        let newUrl = getUrl()
        let dataRequest: DataRequest

        switch method {
        case .get:
            dataRequest = AF.request(newUrl,
                                     method: self.method,
                                     parameters: parameters?.asDictionary(),
                                     encoding: URLEncoding.default,
                                     headers: self.headers).validate()
        default:
            dataRequest = AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters?.asDictionary() ?? [:] {
                    if let temp = value as? String {
                        if let data = temp.data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    } else if let temp = value as? Int {
                        if let data = "\(temp)".data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
                for image in imageUpload ?? [] {
                    multipartFormData.append(image.data, withName: image.fieldName,
                                             fileName: image.fileName, mimeType: image.mimeType)
                }
            }, to: newUrl).validate()
        }

        return Observable<Response>.create { observer -> Disposable in
            let request = dataRequest.responseData { response in

                #if DEBUG
                print("== Network response ==")
                print(" base url: \(APIConstant.baseUrl)")
                print(" path: \(self.urlMethod)")
                if let data = response.data, let body = String(data: data, encoding: .utf8) {
                    print(" body: \(body)")
                }
                #endif

                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    do {
                        let resp = try decoder.decode(Response.self, from: data)

                        guard let status = Int(resp.res.resCode ?? ""), (200...299).contains(status) else {
                            let error = APIError(code: resp.res.resCode ?? "", message: resp.res.resDesc ?? "")
                            observer.onError(error)
                            return
                        }

                        observer.onNext(resp)
                        observer.onCompleted()
                    } catch {
                        do {
                            let resp = try decoder.decode(APIResponse.self, from: data)
                            
                            guard let status = Int(resp.resCode ?? ""), (200...299).contains(status),
                                  let jsonData = resp.toAPIResJson() else {
                                let error = APIError(code: resp.resCode ?? "", message: resp.resDesc ?? "")
                                observer.onError(error)
                                return
                            }

                            let newResp = try decoder.decode(Response.self, from: jsonData)
                            observer.onNext(newResp)
                            observer.onCompleted()

                        } catch(let error) {
                            let status = (error as NSError).code
                            let message = error.localizedDescription
                            let appError = APIError(code: "\(status)", message: message)
                            observer.onError(appError)
                        }
                    }

                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create(with: {
                request.cancel()
            })
        }
    }

}

extension Encodable {

    func asDictionary() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .useDefaultKeys
            let data = try encoder.encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }

    fileprivate func toAPIResJson() -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .useDefaultKeys
            let data = try encoder.encode(self)
            guard var json = String(data: data, encoding: .utf8) else { return nil }
            json = "{ \"res\": \(json) }"
            return json.data(using: .utf8)
        } catch {
            return nil
        }
    }
}
