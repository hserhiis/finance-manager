//
//  CurrencyList.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-12.
//

import SwiftUI

struct CurrencyListView: View {
    @EnvironmentObject var state: GlobalState
    @State private var currencyString: String = ""
    var array: [String: String]
    
    
    var body: some View {
        ForEach(array.map { $0 }, id: \.key) { currency in
            CurrencyListTileView(key: currency.key, value: currency.value)
                .background(currencyString == currency.key ? Color.gray.opacity(0.7) : Color.clear)
            .onTapGesture {
                state.selectedCurrency = currency.key
                print(state.selectedCurrency)
                currencyString = currency.key
            }
                
        }
    }
}
