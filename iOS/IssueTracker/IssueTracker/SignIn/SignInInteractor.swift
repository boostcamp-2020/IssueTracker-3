//
//  SignInInteractor.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import Foundation

protocol SignInBusinessLogic {
    
}

final class SignInInteractor: SignInBusinessLogic {
    // Id pw -> network
    // Id pw 검증 받아서 -> 결과값
}

/* 이런식으로 수정 예정
 protocol SignInBusinessLogic {
     func signInWithGitHub(with provider: ASWebAuthenticationPresentationContextProviding)
     func directToGitHubOAuth()
 }

 final class SignInInteractor: SignInBusinessLogic {
     // Id pw -> network
     // Id pw 검증 받아서 -> 결과값
     let networkService: NetworkServiceProvider = NetworkService()
     let githubOAuthURL = APIServer.baseURL + SignInEndPoint.github.path
 //    let githubOAuthURL = "https://github.com/login/oauth/authorize"
     
     func signInWithGitHub(with provider: ASWebAuthenticationPresentationContextProviding) {
         OAuthManager.init(provider: provider).reqeustToken(url: githubOAuthURL) { token in
             guard token != "" else {
                 print(token)
                 return
             }
             print(token)
         }
     }

     func directToGitHubOAuth() {
         networkService.request(apiConfiguration: SignInEndPoint.github) { response in
             switch response {
             case .failure(_):
                 print("github login 실패")
                 // Error 처리
                 return
             case .success(let data):
                 guard let decodedData: Int = try? data.decoded() else {
                     print("github login decode 실패")
                     return
                 }
             }
         }
     }
 }
 */
