//
//  ContentView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var state: GlobalState
    
    var body: some View {
            VStack {
                HStack {
                    Text("\(removeCommasAndDots(from: state.getBalanceTotal().abbreviated)) \(state.selectedCurrency)")
                        .foregroundStyle(Color.blue)
                        .font(.title)
                }
                .zIndex(99)
                TopBarTabsView()
                if(state.selectedTab.id == 0){
                    IncomeWidgetView()
                }
                if(state.selectedTab.id == 1){
                    ExpenseWidgetView()
                }
                
                Spacer()
            }
            .background(Color.backgroundBlack)
            .navigationTitle(state.selectedTab.title)
            
        }
}
