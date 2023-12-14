//
//  ViewController.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    let viewModel = AccountViewModel()
    @IBOutlet weak var tableView: UITableView!
    var accounts: [Account] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchData { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                print(self.accounts)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setupView() {
        self.title = "Accounts"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AccountTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountTableViewCell")
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as? AccountTableViewCell else {
                    fatalError("Failed to dequeue TransactionCell")
                }
                let account = accounts[indexPath.row]
                cell.configure(with: account)
                return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = TransactionUIView()
        let host = UIHostingController(rootView: view)
        navigationController?.pushViewController(host, animated: true)
    }
    
    
}
