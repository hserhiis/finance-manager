//
//  CurrencyScreenView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct CurrencyScreenView: View {
    @EnvironmentObject var state: GlobalState
    @State private var text: String = ""
    private let height = UIScreen.main.bounds.height - 180
    @State private var currencyString: String = ""
    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack {
                    Text("Choose currency")
                    TextField("Search", text: $text)
                        .padding()
                        .background(Color.textField)
                        .foregroundColor(Color.white)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .padding(.trailing, 20)
                                .foregroundColor(.white)
                                .opacity(0.7),
                            alignment: .trailing
                        )
                        .onChange(of: text, {
                            if text != "" {
                                state.isSearchActive = true
                            } else {
                                state.isSearchActive = false
                            }
                            state.appendFilteredArray(array: currencies, searchedText: text)
                        })
                    
                    List {
                        if state.isSearchActive {
                            CurrencyListView(array: state.filteredArray)
                        } else {
                            CurrencyListView(array: currencies)
                        }
                        
                    }
                    // .(id) -> print(id) implement so i can idetify each row
                    
                }
                NavigationLink(
                    destination: AmountScreenView().navigationBarHidden(true),
                    label: {
                        PrimaryButton(text: "Next")
                    }
                )
                .navigationBarHidden(true)
                .zIndex(99)
                .padding(.top, height)
            }
        }
    }
}

