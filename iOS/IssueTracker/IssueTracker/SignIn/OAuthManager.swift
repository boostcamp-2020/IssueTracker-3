//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/29.
//

import Foundation
import AuthenticationServices

final class OAuthManager {
    private let provider: ASWebAuthenticationPresentationContextProviding
    private let callbackScheme: String
    private let tokenQuery: String
    private var session: ASWebAuthenticationSession?
    
    init(provider presentationContextProvider: ASWebAuthenticationPresentationContextProviding) {
        provider = presentationContextProvider
        callbackScheme = ""
        tokenQuery = "token"
    }
    
    func reqeustToken(url: String, handler: @escaping (String) -> Void) {
        guard let url = try? url.asURL() else { return }
        
        session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { callBackURL, error in
            guard let callBackURL = callBackURL, error == nil else {
                print(String(describing: error?.localizedDescription))
                return
            }
            handler(callBackURL.searchToken(of: self.tokenQuery))
        }
        session?.presentationContextProvider = provider
        session?.start()
    }
}

extension URL {
    func searchToken(of tokenQuery: String) -> String {
        guard let queryItems = URLComponents(string: self.absoluteString)?.queryItems,
              let token = queryItems.first(where: { $0.name == tokenQuery })?.value
        else {
            return ""
        }
        return token
    }
}
