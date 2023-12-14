//
//  TransactionModel.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation

struct TransactionData: Codable {
    let transactions: [Transaction]
}

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let date: TimeInterval
    let value: Double
    let type: String
}

