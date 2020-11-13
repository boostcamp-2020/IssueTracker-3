//
//  SettingViewController.swift
//  IssueTracker
//
//  Created by 송민관 on 2020/11/02.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutTouched(_ sender: UIButton) {
        try? KeychainAccess.shared.removeAll()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyboard
                .instantiateViewController(withIdentifier: "AuthenticationNavigationController")
                as? UINavigationController else {
            return
        }
        self.view.window?.rootViewController = navigationController
    }
}
