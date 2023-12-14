//
//  TransactionUIView.swift
//  BankAccount
//
//  Created by Goushik Kumar T on 14/12/23.
//

import SwiftUI

struct TransactionUIView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = TransactionViewModel()
    @State private var isArrowUp = true

    var body: some View {
        VStack {
            SearchBar(text: $searchText, isArrowUp: $isArrowUp, onToggle: handleToggle)
            List(filteredTransactions, id: \.id) { transaction in
                TransactionCellView(transaction: transaction)
            }
        }
        .navigationBarTitle("Transactions")
        .navigationBarBackButtonHidden(false)
    }
    
    func handleToggle() {
        if isArrowUp {
            print("Arrow is now up!")
            viewModel.setTransactions()
        } else {
            print("Arrow is now down!")
            viewModel.setTransactions(inDesending: false)
        }
    }
    
    private var filteredTransactions: [Transaction] {
        if let searchValue = Double(searchText) {
            if searchValue >= 0 {
                return viewModel.transactions.filter { $0.value >= searchValue }
            } else {
                return viewModel.transactions.filter { $0.value <= searchValue }
            }
        } else {
            return viewModel.transactions
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isArrowUp: Bool
    var onToggle: () -> Void


    var body: some View {
        HStack {
            TextField("Search by value", text: $text)
                .padding(8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                       isArrowUp.toggle()
                        onToggle()
                   }) {
                       Image(systemName: isArrowUp ? "arrow.up" : "arrow.down")
                           .resizable()
                           .frame(width: 25, height: 25)
                   }
                   .padding()
        }

    }
}

struct TransactionUIView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionUIView()
    }
}
