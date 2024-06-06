//
//  AmountScreenView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-12.
//

import SwiftUI

struct AmountScreenView: View {
    @EnvironmentObject var state: GlobalState
    private let height = UIScreen.main.bounds.height - 180
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Choose amount")
                    TextFieldCustomView(text: $text, placeholder: "Enter Amount")
                        .onChange(of: text, {
                            state.setInitialBalance(amount: text)
                        })
                }
                NavigationLink(
                    destination: MainAppView().navigationBarHidden(true),
                    label: {
                        PrimaryButton(text: "Start")
                    }
                )
                .navigationBarHidden(true)
                .zIndex(99)
                .padding(.top, height)
            }
        }
        
    }
}

#Preview {
    AmountScreenView()
}
