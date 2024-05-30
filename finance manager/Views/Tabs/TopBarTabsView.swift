//
//  TopBarTabsView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import SwiftUI

struct TopBarTabsView: View {
    @Binding var selectedTab: TabType
    @EnvironmentObject var state: GlobalState
    
    func getTabBarAmount(for tab: TabType) -> Double {
        switch tab {
        case .income:
            return state.incomeTotal
        case .expenses:
            return state.expensesTotal
        case .balance:
            return state.getBalanceTotal()
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach([TabType.income, TabType.expenses], id: \.self) { tab in
                    TopBarTabView(tab: tab, isSelected: tab == selectedTab, amount: getTabBarAmount(for: tab))
                        .onTapGesture {
                            selectedTab = tab
                        }
                }
            }
            .padding(.horizontal)
        }
        
    }
}
