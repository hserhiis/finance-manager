//
//  ContentView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var selectedTab: TabType = .income
    @EnvironmentObject var state: GlobalState
    
    var body: some View {
            VStack {
                HStack {
                    Text("\(getDeletedComma(value: state.getBalanceTotal().abbreviated)) \(state.selectedCurrency)")
                        .foregroundStyle(Color.blue)
                        .font(.title)
                }
                .zIndex(99)
                TopBarTabsView(selectedTab: $selectedTab)
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
            .background(Color.backgroundBlack)
            .navigationTitle(selectedTab.title)
        }
}
