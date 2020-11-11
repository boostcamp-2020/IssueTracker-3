//
//  SignUpViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var matchPWTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonTouched(_ sender: Any) {
        let networkService = NetworkService()
        let user = User(userID: idTextField.text, password: pwTextField.text)
        
        guard let encodedData = try? JSONEncoder().encode(user) else { return }
        
        networkService.request(apiConfiguration: SignInEndPoint.signUp(encodedData)) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(_:):
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

// MARK: UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case idTextField:
            pwTextField.becomeFirstResponder()
        case pwTextField:
            matchPWTextField.becomeFirstResponder()
        case matchPWTextField:
            nameTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
