//
//  TopBarTabView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import SwiftUI



struct TopBarTabView: View {
    var tab: TabType
    var isSelected: Bool
    var amount: Double
    @EnvironmentObject var state: GlobalState
    private let halfScreenWidth = (UIScreen.main.bounds.width / 2) - 5
    
    
    var body: some View {
        VStack {
            Text(tab.title)
                .foregroundColor(tab.color)
                .font(.subheadline)
                .bold()
                .padding(.top, 18)
                .padding(.bottom, 8)
            
            Text("\(removeCommasAndDots(from: amount.abbreviated)) \(state.selectedCurrency)")
                .foregroundColor(tab.color)
                .padding(.bottom, 18)
        }
        .frame(width: halfScreenWidth)
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
