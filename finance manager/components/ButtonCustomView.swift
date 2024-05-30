//
//  ButtonCustomView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import SwiftUI

struct ButtonCustomView: View {
    @EnvironmentObject var state: GlobalState
    @Binding var amount: String
    @Binding var comment: String
    @Binding var selectedDate: String
    var icon: IconType
    var type: AmountType
    
    
    var body: some View {
        Button("Add") {
            print(selectedDate)
            if let amountValue = Double(amount) {
                if type == .income {
                    state.addIncome(amountValue)
                    state.increaseBalance(amount: amountValue)
                } else {
                    state.addExpense(amountValue)
                    state.decreaseBalance(amount: amountValue)
                }
                
                let newTile = ListTileModel(amount: amountValue, comment: comment, category: icon.title, image: icon.rawValue, type: type)
                state.addListTile(for: selectedDate, tile: newTile)
                amount = ""
                comment = ""
                print(icon.rawValue)
            }
            
        }
        .font(.custom("add", fixedSize: 20))
        .bold()
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .background(Color.buttonAdd)
        .foregroundColor(Color.white)
        .cornerRadius(3)
    }
}
