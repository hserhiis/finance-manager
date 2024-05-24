//
//  CurrencyList.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-12.
//

import SwiftUI

struct CurrencyList: View {
    @EnvironmentObject var state: GlobalState
    var array: [String: String]
    @State private var currencyString: String = ""
    
    var body: some View {
        ForEach(array.map { $0 }, id: \.key) { currency in
            HStack {
                Text(currency.value)
                Spacer()
                Text(currency.key)
            }
            .padding(.vertical, 8)
            .background(currencyString == currency.key ? Color.gray.opacity(0.7) : Color.clear)
            .onTapGesture {
                state.selectedCurrency = currency.key
                print(state.selectedCurrency)
                currencyString = currency.key
            }
        }
    }
}
