//
//  IssueFilterViewController.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/11/02.
//

import UIKit

class IssueFilterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension IssueFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "IssueFilterTableViewCell", for: indexPath)
    }
}

extension IssueFilterViewController: UITableViewDelegate {

}
