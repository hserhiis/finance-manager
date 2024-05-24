//
//  DrawerContent.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct DrawerContent: View {
    @EnvironmentObject var globalState: GlobalState
    @State var isSettingsScreenOpen: Bool = false
    @State var isSignInScreenOpen: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            // Drawer content buttons
            Button(action: {
                globalState.currentScreen = ScreenType.home.id
                globalState.isDrawerOpen = false
            }, label: {
                Text("Home")
            })
            
            Button(action: {
                globalState.currentScreen = ScreenType.list.id
                globalState.isDrawerOpen = false
            }, label: {
                Text("List")
            })
            
            Button(action: {
                globalState.currentScreen = ScreenType.goal.id
                globalState.isDrawerOpen = false
            }, label: {
                Text("Goal")
            })
            
            Button(action: {
                globalState.isDrawerOpen = false
                isSettingsScreenOpen = true
            }, label: {
                Text("Settings")
            })
            .background(
                NavigationLink("", isActive: $isSettingsScreenOpen, destination: {
                    SettingsScreenView()
                })
            )
            Button(action: {
                globalState.isDrawerOpen = false
                isSignInScreenOpen = true
            }, label: {
                Text("Sign out")
            })
            .background(
                NavigationLink("", isActive: $isSignInScreenOpen) {
                    SignInScreenView()
                        .navigationBarBackButtonHidden()
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
}

