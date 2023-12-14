//
//  AccountViewModel.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import Foundation

class AccountViewModel {
    let apiService = APIService.shared
    
    private func formatAccount(with accounts: [Account]) -> [Account]{
        var updatedAccount = accounts
        updatedAccount.sort { $0.number < $1.number }
        return updatedAccount
    }

    func fetchData(completion: @escaping (Result<[Account], Error>) -> Void) {
        let url = URL(string: "https://m.timwang.au/accounts.json")!
        apiService.fetchData(url: url) { (result: Result<[Account], APIServiceError>) in
            switch result {
            case .success(let accounts):
                let formatedAccounts =  self.formatAccount(with: accounts)
                completion(.success((formatedAccounts)))
            case .failure(let error):
                //Add conditions
                completion(.failure(error))
            }
        }
    }
}
