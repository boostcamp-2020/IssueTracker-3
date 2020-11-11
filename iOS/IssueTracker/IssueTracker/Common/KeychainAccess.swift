//
//  KeychainAccess.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

enum KeychainError: Error {
  case updateFailed(key: String, description: String)
  case insertFailed(key: String, description: String)
  case removeFailed(key: String, description: String)
}

struct KeychainAccess {
    static let shared = KeychainAccess(serviceName: "bundleID")

    let serviceName: String

    func get(forAccountKey account: String) -> String? {
        let query = baseQueryDictionary()
        query[kSecReturnData] = true
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecAttrAccount] = account
        var queryResult: AnyObject?
        let readStatus = SecItemCopyMatching(query, &queryResult)
        if readStatus != errSecSuccess {
            debugPrint("Failed to retrieve data for key: \(account).")
            debugPrint("Reason: \(securityErrorMeesage(fromStatus: readStatus))")
            return nil
        }
        guard let passwordData = queryResult as? Data else {
            debugPrint("Failed to convert query result to data")
            return nil
        }
        return String(data: passwordData, encoding: .utf8)
    }

    func set(_ value: String?, forAccountKey account: String) throws {
        guard let value = value else {
            try removeValue(forAccountKey: account)
            return
        }

        if exists(forAccountKey: account) {
            try update(value, forAccountKey: account)
        } else {
            try insert(value, forAccountKey: account)
        }
    }

    func exists(forAccountKey account: String) -> Bool {
        let query = baseQueryDictionary()
        query[kSecReturnData] = false
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecAttrAccount] = account
        let readStatus = SecItemCopyMatching(query, nil)
        if readStatus == errSecSuccess {
            return true
        }
        if readStatus != errSecItemNotFound {
            debugPrint("Failed to query existence of key: \(account).")
            debugPrint("Reason: \(securityErrorMeesage(fromStatus: readStatus))")
        }
        return false
    }

    func removeValue(forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecAttrAccount] = account
        let deleteStatus = SecItemDelete(query)
        if deleteStatus != errSecSuccess {
            throw KeychainError.removeFailed(key: account, description: securityErrorMeesage(fromStatus: deleteStatus))
        }
    }

    func removeAll() throws {
        let deleteStatus = SecItemDelete(baseQueryDictionary())
        if deleteStatus != errSecSuccess {
            throw KeychainError.removeFailed(key: "ALL", description: securityErrorMeesage(fromStatus: deleteStatus))
        }
    }

    private func insert(_ value: String, forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecValueData] = value.data(using: .utf8)
        query[kSecAttrAccount] = account
        let saveStatus = SecItemAdd(query, nil)
        if saveStatus != errSecSuccess {
            throw KeychainError.insertFailed(key: account, description: securityErrorMeesage(fromStatus: saveStatus))
        }
    }

    private func update(_ value: String, forAccountKey account: String) throws {
        let query = baseQueryDictionary()
        query[kSecAttrAccount] = account
        let attributesToUpdate = [kSecValueData: value.data(using: .utf8)!,
                                  kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock] as NSDictionary
        let updateStatus = SecItemUpdate(query, attributesToUpdate)
        if updateStatus != errSecSuccess {
            throw KeychainError.updateFailed(key: account, description: securityErrorMeesage(fromStatus: updateStatus))
        }
    }

    private func baseQueryDictionary() -> NSMutableDictionary {
        return [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock] as NSMutableDictionary
    }

    private func securityErrorMeesage(fromStatus status: OSStatus) -> String {
        if #available(iOS 11.3, *), let errorMessage = SecCopyErrorMessageString(status, nil) {
            return errorMessage as String
        } else {
            return "error code: \(status)"
        }
    }
}
