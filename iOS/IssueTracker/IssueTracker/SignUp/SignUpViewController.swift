//
//  SignUpViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit
import Combine

final class SignUpViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    @IBOutlet private weak var matchPWTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    
    private var keyboardShowObserver: AnyCancellable?
    private var keyboardHideObserver: AnyCancellable?
    private var currentTextField: UITextField?
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureObservers()
    }
    
    // MARK: Configure
    
    private func configureObservers() {
        keyboardShowObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in self?.keyboardWillShow(notification) }
        
        keyboardHideObserver = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in self?.keyboardWillHide() }
    }
    
    // MARK: Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
    
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect =  keyboardFrame.cgRectValue
        guard let currentTextField = currentTextField else { return }

        if currentTextField.frame.maxY + 200 > keyboardRect.origin.y {
            let distance = (currentTextField.frame.maxY - keyboardRect.origin.y + 200)
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.transform = CGAffineTransform(translationX: 0, y: -distance)
            }
        }
    }
    
    private func keyboardWillHide() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.transform = .identity
        }
    }
}

// MARK: UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        currentTextField = nil
        switch textField {
        case idTextField:
            pwTextField.becomeFirstResponder()
            currentTextField = pwTextField
        case pwTextField:
            matchPWTextField.becomeFirstResponder()
            currentTextField = matchPWTextField
        case matchPWTextField:
            nameTextField.becomeFirstResponder()
            currentTextField = nameTextField
        default:
            break
        }
        return true
    }
}
