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
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
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
