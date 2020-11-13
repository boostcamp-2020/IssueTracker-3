//
//  AppleUser.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/13.
//

import Foundation

final class AppleUser {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var authorizationCode: String?
    var identityToken: String?

    init(_ id: String?,
         _ firstName: String?,
         _ lastName: String?,
         _ email: String?,
         _ password: String?,
         _ authorizationCode: String?,
         _ identityToken: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.authorizationCode = authorizationCode
        self.identityToken = identityToken
    }
}
