//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit
import AuthenticationServices
import Combine

final class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var signInWithAppleView: AppleSignInButton!
    
    private var interactor: SignInBusinessLogic!
    private var keyboardShowObserver: AnyCancellable?
    private var keyboardHideObserver: AnyCancellable?
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureSignInWithAppleView()
        configureObservers()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Setup
    
    private func setup() {
        interactor = SignInInteractor()
    }

    @IBAction func loginTouched(_ sender: Any) {
        let networkService = NetworkService()
        let user = User(userID: idTextField.text, password: pwTextField.text)
        var flag = false

        if user.userID == "" {
            idTextField.shake()
            flag = true
        }
        if user.password == "" {
            pwTextField.shake()
            flag = true
        }

        guard !flag else { return }

        guard let encodedData = try? JSONEncoder().encode(user) else { return }

        networkService.request(apiConfiguration: SignInEndPoint.signIn(encodedData)) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let data):
                guard let data: RequestLogin = try? data.decoded() else { return }
                self.changeViewController(jwt: data.jwt)
            }
        }
    }
    
    // MARK: Configure
    
    private func configureObservers() {
        keyboardShowObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] _ in self?.keyboardWillShow() }
        
        keyboardHideObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in self?.keyboardWillHide() }
    }
    
    private func configureSignInWithAppleView() {
        signInWithAppleView.didCompletedSignIn = { [weak self] (user) in
            // user.identityToken = JWT 토큰을 풀어서 name, email 가져오기, 서버로 보내기
            // user.authorizationCode = 서버로 보낼 코드 // 5분만
            
            guard let self = self,
                  let code = user.authorizationCode,
                  let token = user.identityToken else {
                return
            }
            
            self.appleLoginNetworkService(authorizationCode: code, identityToken: token) { jwt in
                self.changeViewController(jwt: jwt)
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
    
    private func changeViewController(jwt: String?) {
        guard let jwt = jwt else { return }
        NetworkService.token = jwt
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
                    as? UITabBarController else { return }
            
            self.view.window?.rootViewController = tabBarController
        }
    }
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func keyboardWillShow() {
        view.frame.origin.y = -60
    }
    
    private func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    @IBAction func signInWithGitHubTouched(_ sender: UIButton) {
        let baseURL = APIServer.baseURL
        let url = baseURL + SignInEndPoint.github.path
        OAuthManager.init(provider: self).reqeustToken(url: url) { [weak self] jwt in
            guard jwt != "" else {
                debugPrint("jwt가 비어있습니다.")
                return
            }
            self?.changeViewController(jwt: jwt)
        }
        // interactor.signInWithGitHub(with: self)
    }
}

// MARK: UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == idTextField {
            pwTextField.becomeFirstResponder()
        }
        return true
    }
}

// MARK: ASWebAuthenticationPresentationContextProviding

extension SignInViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}

// MARK: ASAuthorizationControllerPresentationContextProviding

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
}
