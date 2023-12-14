//
//  AccountModel.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation

struct Account: Codable {
    let type: String
    let number: String
    let balance: Double
}
