//
//  SignUpViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var matchPasswordLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signUpButtonTouched(_ sender: Any) {
        let networkService = NetworkService()
        let user = User(userID: idLabel.text, password: passwordLabel.text)

        guard let encodedData = try? JSONEncoder().encode(user) else { return }

        networkService.request(apiConfiguration: SignInEndPoint.signUp(encodedData)) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(_:):
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
