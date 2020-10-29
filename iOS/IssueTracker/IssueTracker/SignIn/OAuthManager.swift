//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/29.
//

import Foundation
import AuthenticationServices

final class OAuthManager {
    private let presentationContextProvider: ASWebAuthenticationPresentationContextProviding
    private let callbackScheme: String
    private let tokenQuery: String = "token"
    private var webAuthSession: ASWebAuthenticationSession?
    
    init(provider: ASWebAuthenticationPresentationContextProviding) {
        presentationContextProvider = provider
        callbackScheme = ""
    }
    
    func reqeustToken(url: String, handler: @escaping (String) -> Void) {
        guard let url = try? url.asURL() else { return }
        
        
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { callBack, error in
//            guard error == nil, let callbackURL = callBack else {
//                return
//            }
//            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
//
//            guard let token = queryItems?.filter({ $0.name == self.tokenQuery }).first?.value else {
//                return
//            }
//            handler(token)
        }
        
        session.presentationContextProvider = presentationContextProvider
        session.start()
    }
}
