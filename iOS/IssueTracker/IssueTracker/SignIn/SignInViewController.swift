//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit
import AuthenticationServices
import Alamofire

final class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var signInWithAppleView: AppleSignInButton!

    // MARK: View Cycle

    var text: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignInWithAppleView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }

    func configureSignInWithAppleView() {
        signInWithAppleView.didCompletedSignIn = { [weak self] (user) in
            // user.identityToken = JWT 토큰을 풀어서 name, email 가져오기, 서버로 보내기
            // user.authorizationCode = 서버로 보낼 코드 // 5분만

            guard let self = self,
                  let code = user.authorizationCode,
                  let token = user.identityToken else {
                return
            }

            self.appleLoginNetworkService(authorizationCode: code, identityToken: token) {
                self.showResultViewController(userIdentifier: user.id,
                                              givenName: user.firstName,
                                              familyName: user.lastName,
                                              email: user.email)
            }
        }
    }

    private func appleLoginNetworkService(authorizationCode code: String,
                                          identityToken token: String,
                                          handler: @escaping () -> Void) {
        let appleModel = AppleLogin(authorizationCode: code, identityToken: token)
        let networkService = NetworkService()
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase

        guard let encodedData = try? jsonEncoder.encode(appleModel) else { return }

        networkService.request(apiConfiguration: SignInEndPoint.apple(encodedData)) { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let data):
                guard let decodedData: RequestLogin = try? data.decoded() else {
                    return
                }
                handler()
            }
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        try? KeychainItem(service: "com.example.apple-samplecode.juice",
                          account: "userIdentifier").saveItem(userIdentifier)

    }

    private func showResultViewController(userIdentifier: String?,
                                          givenName: String?,
                                          familyName: String?,
                                          email: String?) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
                    as? UITabBarController else { return }

            self.view.window?.rootViewController = tabBarController
        }
    }

    // MARK: Action Functions
    
    @IBAction func signInWithGitHubTouched(_ sender: UIButton) {
        OAuthManager.init(provider: self).reqeustToken(url: SignInEndPoint.github.path) { token in
            guard token != "" else {
                print("nilnil닐닐")
                return
            }
            print(token)
        }
    }
    
    @IBAction func signInWithAppleTouched(_ sender: UIButton) {
        // TODO: 애플 로그인 검증
    }
}

extension SignInViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let selfView = self.view.window else {
            return ASPresentationAnchor()
        }
        return selfView
    }
}
