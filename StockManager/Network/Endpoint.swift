//
//  Endpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import Alamofire
import RxSwift

protocol Endpoint {
    associatedtype Request: Codable
    associatedtype Response: BaseAPIResponse

    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
}

extension Endpoint {

    func request(parameters: Request? = nil) -> Observable<Response> {
        let newUrl = "\(APIConstant.baseUrl)\(self.url)"
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
            }, to: newUrl).validate()
        }

        return Observable<Response>.create { observer -> Disposable in
            let request = dataRequest.responseDecodable { (response: DataResponse<Response, AFError>) in
                switch response.result {
                case .success(let data):
                    #if DEBUG
                    print("== Network response ==")
                    print(" base url: \(APIConstant.baseUrl)")
                    print(" path: \(self.url)")
                    if let data = response.data, let body = String(data: data, encoding: .utf8) {
                        print(" body: \(body)")
                    }
                    #endif
                    
                    guard let status = Int(data.res.resCode ?? ""), (200...299).contains(status) else {
                        let error = APIError(code: data.res.resCode ?? "", message: data.res.resDesc ?? "")
                        observer.onError(error)
                        return
                    }

                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    #if DEBUG
                    print("== Network response ==")
                    print(" base url: \(APIConstant.baseUrl)")
                    print(" path: \(self.url)")
                    if let data = response.data, let body = String(data: data, encoding: .utf8) {
                        print(" body: \(body)")
                    }
                    #endif
                    
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
}
