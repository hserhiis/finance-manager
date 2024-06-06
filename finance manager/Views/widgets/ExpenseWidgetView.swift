//
//  ExpenseWidgetView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct ExpenseWidgetView: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var amount: String = ""
    @State private var comment: String = ""
    @State private var selectedIcon: IconType = .home
    @State private var selectedDate: String = formattedDate(from: Date.now, dateType: .yearMonthDay, dayType: .today)
    
    var body: some View {
        VStack {
            
            TextFieldCustomView(text: $amount, placeholder: "Amount")
            
            HStack {
                TextFieldCustomView(text: $comment, placeholder: "Comment")
                    .frame(width: 220)
                
                Picker("Select Icon", selection: $selectedIcon) {
                    ForEach(IconType.allCases, id: \.self) { icon in
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
            
            DateWidgetView(selectedDate: $selectedDate)
            
            Spacer()
            ProgressBarView()
            Spacer()
            
            HStack {
                Spacer()
                ButtonCustomView(amount: $amount, comment: $comment, selectedDate: $selectedDate, icon: selectedIcon, type: .expense)
            }
        }
    }
}

