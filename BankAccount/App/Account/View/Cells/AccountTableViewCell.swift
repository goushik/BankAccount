//
//  AccountTableViewCell.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowRadius = 3
        mainView.layer.shadowColor  = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with account: Account) {
//        typeLabel.text = "Type: \(transaction.type)"
        accountNumberLabel.text = account.number
        balanceLabel.text = "$\(account.balance)"
        typeLabel.text = account.type
    }
    
}
