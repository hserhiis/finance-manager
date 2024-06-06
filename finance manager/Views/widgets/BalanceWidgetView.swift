//
//  BalanceWidgetView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct BalanceWidgetView: View {
    @EnvironmentObject var state: GlobalState
    var body: some View {
        Text("\(removeCommasAndDots(from: state.getBalanceTotal().abbreviated)) \(state.selectedCurrency)")
            .foregroundStyle(Color.blue)
    }
}

#Preview {
    BalanceWidgetView()
}
