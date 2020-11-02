//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

class IssueFilterViewController: UIViewController {
    @IBOutlet weak var issueFilterTableView: UITableView!
    @IBOutlet weak var headerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        issueFilterTableView.dataSource = self
        issueFilterTableView.delegate = self

    }
    
    @IBAction func cancelButtonTouched(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTouched(_ sender: UIBarButtonItem) {
        
    }
}

extension IssueFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

extension IssueFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "IssueFilterTableViewCell", for: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 {
            return HeaderView(text: "다음 중에 조건을 고르세요")
        }
        return HeaderView(text: "세부 조건")
    }
}
