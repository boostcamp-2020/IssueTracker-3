//
//  UserDefault.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/10.
//

import Foundation

@propertyWrapper
struct UserDefault {
    private let key: String
    private let defaultValue: String

    init(_ key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: String {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let cart = try? JSONDecoder().decode(String.self, from: data) {
                return cart
            }
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
