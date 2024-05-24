//
//  ContentView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

enum TabType {
    case income
    case expenses
    case balance
    
    var title: String {
        switch self {
        case .income: return "Income"
        case .expenses: return "Expenses"
        case .balance: return "Balance"
        }
    }
    
    var color: Color {
        switch self {
        case .income: return .green
        case .expenses: return .red
        case .balance: return .blue
        }
    }
    
    var id: Int {
        switch self {
        case .income: return 0
        case .expenses: return 1
        case .balance: return 2
        }
    }
}

struct HomeScreenView: View {
    @State private var selectedTab: TabType = .income
    
    var body: some View {
        VStack {
            TopBarBlocksView(selectedTab: $selectedTab)
            if(selectedTab.id == 0){
                IncomeWidgetView()
            }
            if(selectedTab.id == 1){
                ExpenseWidgetView()
            }
            if(selectedTab.id == 2){
                BalanceWidgetView()
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
        .background(Color.backgroundBlack)
        .navigationTitle(selectedTab.title)
    }
}

struct TopBarBlocksView: View {
    @Binding var selectedTab: TabType
    @EnvironmentObject var globalState: GlobalState
    
    func getBlockTabBarAmount(for tab: TabType) -> Double {
        switch tab {
        case .income:
            return globalState.incomeTotal
        case .expenses:
            return globalState.expensesTotal
        case .balance:
            return globalState.balanceTotal
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach([TabType.income, TabType.expenses, TabType.balance], id: \.self) { tab in
                TopTabBarBlockView(tab: tab, isSelected: tab == selectedTab, amount: getBlockTabBarAmount(for: tab))
                    .onTapGesture {
                        selectedTab = tab
                    }
            }
        }
        .padding(.horizontal)
    }
}


struct TopTabBarBlockView: View {
    var tab: TabType
    var isSelected: Bool
    var amount: Double
    
    var body: some View {
        VStack {
            Text(tab.title)
                .foregroundColor(tab.color)
                .font(.subheadline)
                .bold()
                .padding(.top, 18)
                .padding(.bottom, 8)
            
            Text("\(amount, specifier: doubleSpecifier) CAD")
                .foregroundColor(tab.color)
                .padding(.bottom, 18)
        }
        .frame(width: 126)
        .background(
            VStack {
                Color(white: 0.1)
                if isSelected {
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(tab.color)
                        .frame(height: 6)
                }
            }
        )
        .cornerRadius(3)
    }
}




#Preview {
    HomeScreenView()
}
