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

    func configureSignInWithAppleView() {
        signInWithAppleView.didCompletedSignIn = { [weak self] (user) in
            // user.identityToken = JWT 토큰을 풀어서 name, email 가져오기, 서버로 보내기
            // user.authorizationCode = 서버로 보낼 코드 // 5분만

            self?.showResultViewController(userIdentifier: user.id,
                                           givenName: user.firstName,
                                           familyName: user.lastName,
                                           email: user.email)
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice",
                             account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }

    private func showResultViewController(userIdentifier: String?,
                                          givenName: String?,
                                          familyName: String?,
                                          email: String?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                as? ViewController else { return }

        loginViewController.modalPresentationStyle = .formSheet
        loginViewController.isModalInPresentation = true
        self.present(loginViewController, animated: true, completion: nil)

        DispatchQueue.main.async {
        }
    }
  
    // MARK: Action Functions
    
    @IBAction func signInTouched(_ sender: UIButton) {
        // TODO: idTextField.text / pwTextField.text => 인터렉터(검증)
    }
    
    // TODO: 로그인 실패/성공 : toast
    
    @IBAction func signInWithGitHubTouched(_ sender: UIButton) {
        let path = "http://101.101.210.34:3000/auth/github"
//        let path = "https://github.com/login/oauth/authorize"
        OAuthManager.init(provider: self).reqeustToken(url: path) { token in
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
