//
//  SignInViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/10/27.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet private weak var idTextField: UITextField!
    @IBOutlet private weak var pwTextField: UITextField!
    
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Action Functions
    
    @IBAction func signInTouched(_ sender: UIButton) {
        // TODO: idTextField.text / pwTextField.text => 인터렉터(검증)
        
    }
    
    // TODO: 로그인 실패/성공 : toast
    
    @IBAction func signInWithGitHubTouched(_ sender: UIButton) {
        // TODO: 깃허브 로그인 검증
    }
    
    @IBAction func signInWithAppleTouched(_ sender: UIButton) {
        // TODO: 애플 로그인 검증
    }
}
