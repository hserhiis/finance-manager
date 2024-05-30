//
//  ContentView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalState: GlobalState

    var body: some View {
        if globalState.isLoggedIn {
            MainAppView()
        } else if globalState.isSignedUp {
            CurrencyScreenView()
        } else {
            SignInScreenView()
        }
    }
}
