//
//  KeyChain.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/09.
//

import Foundation
//
//@propertyWrapper
//struct KeyChain {
//    private let key: String
//    private let defaultValue: String
//
//    init(_ key: String, defaultValue: String) {
//        self.key = key
//        self.defaultValue = defaultValue
//    }
//
//    var wrappedValue: String {
//        get {
//            if let data = UserDefaults.standard.object(forKey: key) as? Data,
//               let cart = try? JSONDecoder().decode(String.self, from: data) {
//                return cart
//            }
//            return defaultValue
//        }
//        set {
//            if let encoded = try? JSONEncoder().encode(newValue) {
//                UserDefaults.standard.set(encoded, forKey: key)
//            }
//        }
//    }
//
//}

@propertyWrapper
struct KeyChain {
    let key: String
    let defaultValue: String

    init(key: String, defaultValue: String = "") {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: String {
        get {
            return KeychainAccess.shared.get(forAccountKey: key) ?? defaultValue
        }
        set {
            do {
                try KeychainAccess.shared.set(newValue, forAccountKey: key)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
