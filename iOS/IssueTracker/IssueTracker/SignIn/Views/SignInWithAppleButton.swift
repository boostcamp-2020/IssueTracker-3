//
//  SignInWithAppleButton.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/10/29.
//

import UIKit
import AuthenticationServices

@IBDesignable
class AppleSignInButton: UIView {
    private var appleButton = ASAuthorizationAppleIDButton()
    var didCompletedSignIn: ((_ user: AppleUser) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }

    @IBInspectable
    private var style: Int = ASAuthorizationAppleIDButton.Style.black.rawValue {
        didSet {
            let buttonType = ASAuthorizationAppleIDButton.ButtonType(rawValue: type)
                ?? ASAuthorizationAppleIDButton.ButtonType.default

            let buttonStyle = ASAuthorizationAppleIDButton.Style(rawValue: style)
                ?? ASAuthorizationAppleIDButton.Style.black

            appleButton = ASAuthorizationAppleIDButton.init(type: buttonType, style: buttonStyle)
            setUpView()
        }
    }

    @IBInspectable
    private var type: Int = ASAuthorizationAppleIDButton.ButtonType.default.rawValue {
        didSet {
            let buttonType = ASAuthorizationAppleIDButton.ButtonType(rawValue: type)
                ?? ASAuthorizationAppleIDButton.ButtonType.default

            let buttonStyle = ASAuthorizationAppleIDButton.Style(rawValue: style)
                ?? ASAuthorizationAppleIDButton.Style.black
            
            appleButton = ASAuthorizationAppleIDButton.init(type: buttonType, style: buttonStyle)
            setUpView()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }

    private func setUpView() {
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appleButton)

        NSLayoutConstraint.activate([
            appleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            appleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            appleButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            appleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])

        appleButton.addTarget(self, action: #selector(didTapASAuthorizationButton), for: .touchUpInside)
    }

    @objc private func didTapASAuthorizationButton() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController.init(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: - Presentation Context Provider Delegate
extension AppleSignInButton: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
}

// MARK: - ASAuthorizationController Delegate
extension AppleSignInButton: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alertBox = UIAlertController.init(title: AppSignInStrings.appleSignInFailedTitle.localized,
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
        alertBox.addAction(UIAlertAction.init(title: AppSignInStrings.appleSignInOk.localized,
                                              style: .default,
                                              handler: nil))
        self.window?.rootViewController?.present(alertBox, animated: true, completion: nil)
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            guard let authorization = credentials.authorizationCode else { break }
            guard let jwt = credentials.identityToken  else { break }

            let data = String(data: authorization, encoding: .utf8)
            let data2 = String(data: jwt, encoding: .utf8)

            didCompletedSignIn?(AppleUser(credentials.user,
                                          credentials.fullName?.givenName,
                                          credentials.fullName?.familyName,
                                          credentials.email,
                                          nil,
                                          credentials.authorizationCode,
                                          credentials.identityToken))
        case let passwordCredential as ASPasswordCredential:
            didCompletedSignIn?(AppleUser(passwordCredential.user,
                                          nil,
                                          nil,
                                          nil,
                                          passwordCredential.password,
                                          nil,
                                          nil))
        default:
            break
        }

    }
}

private enum AppSignInStrings: String {
    case appleSignInFailedTitle = "로그인 실패"
    case appleSignInOk = "확인"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class AppleUser {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var authorizationCode: Data?
    var identityToken: Data?

    init(_ id: String?,
         _ firstName: String?,
         _ lastName: String?,
         _ email: String?,
         _ password: String?,
         _ authorizationCode: Data?,
         _ identityToken: Data?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.authorizationCode = authorizationCode
        self.identityToken = identityToken
    }
}
