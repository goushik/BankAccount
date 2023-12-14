//
//  TransactionViewModel.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var transactions: [Transaction] = []

    private var cancellables: Set<AnyCancellable> = []
    let apiService = APIService.shared

    init() {
        loadTransactions()
    }
    
    func setTransactions(inDesending: Bool = true) {
        if inDesending {
            DispatchQueue.main.async {
                self.transactions = self.transactions.sorted(by: { $0.date > $1.date })
            }
        } else {
            DispatchQueue.main.async {
                self.transactions = self.transactions.sorted(by: { $0.date < $1.date })
            }        }
    }

    private func loadTransactions() {
        let url = URL(string: "https://m.timwang.au/transactions.json")!
        apiService.fetchData(url: url) { (result: Result<TransactionData, APIServiceError>) in
            switch result {
            case .success(let loadedTransactions):
//                let sortedTransactions = loadedTransactions.transactions.sorted(by: { $0.date > $1.date })
//                DispatchQueue.main.async {
//                    self.transactions = sortedTransactions
//                }
                self.transactions = loadedTransactions.transactions
                self.setTransactions()
            case .failure(let error):
                print("Error loading transactions: \(error)")
            }
        }
    }
}

