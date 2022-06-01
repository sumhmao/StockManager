//
//  UserContext.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import Locksmith

final class UserContext {

    static let shared = UserContext()
    static let logoutNotificationKey = "LogoutNotificationKey"
    private let userAccount = "Zort-User-Account"
    private let userDataKey = "User-Context"

    private(set) var merchant: Merchant? = nil

    var loggedIn: Bool {
        return merchant != nil
    }

    private init() {
        do {
            guard let userData = Locksmith.loadDataForUserAccount(userAccount: userAccount),
                  let userJson = userData[userDataKey] as? String,
                  let jsonData = userJson.data(using: .utf8) else { return }

            let jsonDecoder = JSONDecoder()
            self.merchant = try jsonDecoder.decode(Merchant.self, from: jsonData)

        } catch {}
    }

    private func saveMerchantData() {
        do {
            guard let merchant = merchant else { return }
            var userData: [String : Any] = Locksmith.loadDataForUserAccount(userAccount: userAccount) ?? [:]
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(merchant)
            guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { return }
            userData[userDataKey] = json
            try Locksmith.updateData(data: userData, forUserAccount: userAccount)

        } catch(let error) {
            print(error.localizedDescription)
        }
    }

    func saveMerchant(_ data: Merchant) {
        self.merchant = data
        saveMerchantData()
    }

    func logout() {
        merchant = nil
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
        } catch {}

        NotificationCenter.default.post(name: Notification.Name(rawValue: UserContext.logoutNotificationKey),
                                        object: nil)
    }

}
