//
//  IncomeWidgetView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI




struct IncomeWidgetView: View {
    @EnvironmentObject var globaState: GlobalState
    @State private var amount: String = ""
    @State private var comment: String = ""
    @State private var selectedIcon: IconType = .home
    
    
    
    var body: some View {
        Text("Income")
            .foregroundStyle(Color.green)
        TextFieldCustomView(text: $amount, placeholder: "Amount")
        HStack {
            TextFieldCustomView(text: $comment, placeholder: "Comment")
                .frame(width: 220)
            Picker("Select Icon", selection: $selectedIcon) {
                ForEach(IconType.allCases) { icon in
                    HStack {
                        Image(systemName: icon.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        Text(icon.title)
                    }
                        
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        
        Button("Add") {
            if let amountValue = Double(amount) {
                globaState.addIncome(amountValue)
                let newTile = ListTile(amount: amountValue, comment: comment, category: selectedIcon.title, image: selectedIcon.rawValue, type: .income)
                globaState.addListTile(for: formattedDateOnly(from: currentDate), tile: newTile)
                amount = ""
                comment = ""
                print(selectedIcon.rawValue)
            }
            
        }
        
        

    }
}

#Preview {
    IncomeWidgetView()
}
