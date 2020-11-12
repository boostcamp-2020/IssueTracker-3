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
        let networkService = NetworkService()

        guard let url = try? url.asURL() else { return }

        session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { callBackURL, error in

            guard let callBackURL = callBackURL, error == nil else {
                print(String(describing: error?.localizedDescription))
                return
            }

            let encodedData = CallBackUrl(url: callBackURL.absoluteString).encoded()

            networkService.request(apiConfiguration: SignInEndPoint.token(encodedData)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                    return
                case .success(let data):
                    guard let decodedData: RequestLogin = try? data.decoded(),
                          let jwt = decodedData.jwt else { return }

                    handler(jwt)
                }
            }

        }

        session?.presentationContextProvider = provider
        session?.prefersEphemeralWebBrowserSession = true
        session?.start()
    }
}

struct CallBackUrl: Codable {
    let url: String
}
