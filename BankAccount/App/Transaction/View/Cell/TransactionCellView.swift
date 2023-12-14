//
//  TransactionCellView.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import SwiftUI

struct TransactionCellView: View {
    let transaction: Transaction
    init(transaction: Transaction) {
           self.transaction = transaction
       }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Type: \(transaction.type)")
                    .font(.headline)
                Text("\(formatDate(transaction.date))")
                    .font(.subheadline)
            }
            Spacer()
            Text("$\(String(format: "%.2f", transaction.value))")
                .font(.headline)
                .foregroundColor(transaction.value < 0 ? .red : .green)
        }
        .padding(8)
    }

    private func formatDate(_ timestamp: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM HH:mm"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}

struct TransactionCellView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCellView(transaction: Transaction(date: 721608108, value: 0.0, type: ""))
    }
}
