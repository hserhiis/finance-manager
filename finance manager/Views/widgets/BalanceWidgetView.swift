//
//  BalanceWidgetView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct BalanceWidgetView: View {
    @EnvironmentObject var globalState: GlobalState
    var body: some View {
        Text("\(globalState.balanceTotal, specifier: doubleSpecifier) CAD")
            .foregroundStyle(Color.blue)
    }
}

#Preview {
    BalanceWidgetView()
}
