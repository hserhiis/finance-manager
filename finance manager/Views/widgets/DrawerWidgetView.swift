//
//  DrawerContent.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI
import FirebaseAuth

struct DrawerWidgetView: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var isSettingsScreenOpen: Bool = false
    @State private var isSignInScreenOpen: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            // Drawer content buttons
            NavigationButton(title: "Home", action: {
                globalState.currentScreen = ScreenType.home.id
                globalState.isDrawerOpen = false
            })
            
            NavigationButton(title: "List", action: {
                globalState.currentScreen = ScreenType.list.id
                globalState.isDrawerOpen = false
            })
            
            NavigationButton(title: "Goal", action: {
                globalState.currentScreen = ScreenType.goal.id
                globalState.isDrawerOpen = false
            })
            
            NavigationButton(title: "Settings", action: {
                globalState.isDrawerOpen = false
                isSettingsScreenOpen = true
            })
            .background(
                NavigationLink("", isActive: $isSettingsScreenOpen) {
                    SettingsScreenView()
                }
            )
            
            NavigationButton(title: "Sign out", action: {
                globalState.isDrawerOpen = false
                Task {
                    await globalState.updateUserData()
                }
                
                signOut()
            })
            .background(
                NavigationLink("", isActive: $isSignInScreenOpen) {
                    SignInScreenView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                }
            )
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.drawer)
        .onTapGesture {
            if globalState.isDrawerOpen {
                globalState.isDrawerOpen.toggle()
            }
        }
    }
    
    private func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            isSignInScreenOpen = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct NavigationButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
