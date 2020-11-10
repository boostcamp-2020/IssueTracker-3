//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit
import AuthenticationServices

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

    @IBAction func loginTouched(_ sender: Any) {
        let networkService = NetworkService()
        let user = User(userID: idTextField.text, password: pwTextField.text)

        guard let encodedData = try? JSONEncoder().encode(user) else { return }

        networkService.request(apiConfiguration: SignInEndPoint.signIn(encodedData)) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let data):
                guard let data: RequestLogin = try? data.decoded() else { return }
                self.viewControllerChange(jwt: data.jwt)
            }
        }
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

            self.appleLoginNetworkService(authorizationCode: code, identityToken: token) { jwt in
                self.viewControllerChange(jwt: jwt)
            }
        }
    }

    private func appleLoginNetworkService(authorizationCode code: String,
                                          identityToken token: String,
                                          handler: @escaping (String?) -> Void) {
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
                handler(decodedData.jwt)
            }
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        try? KeychainItem(service: "com.example.apple-samplecode.juice",
                          account: "userIdentifier").saveItem(userIdentifier)

    }

    private func viewControllerChange(jwt: String?) {
        guard let jwt = jwt else { return }
        NetworkService.token = jwt
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
                    as? UITabBarController else { return }

            self.view.window?.rootViewController = tabBarController
        }
    }

    // MARK: Action Functions
    
    @IBAction func signInWithGitHubTouched(_ sender: UIButton) {
        let baseURL = APIServer.baseURL
        let url = baseURL + SignInEndPoint.github.path
        OAuthManager.init(provider: self).reqeustToken(url: url) { token in
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
