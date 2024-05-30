//
//  MainAppView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject private var globalState: GlobalState
    private let width = UIScreen.main.bounds.width - 100
    
    var body: some View {
        NavigationView {
                ZStack(alignment: .leading) {
                    // Drawer content
                    DrawerWidgetView()
                        .frame(width: width)
                        .offset(x: globalState.isDrawerOpen ? 0 : -width)
                        .animation(.default)
                        .zIndex(99)
                    // Content behind the drawer
                    VStack {
                        HStack {
                            ButtonDrawer(state: globalState)
                        }
                            TabView(selection: $globalState.currentScreen) {
                                HomeScreenView()
                                    .tabItem {
                                        Label(ScreenType.home.rawValue, systemImage:ScreenType.home.iconName)
                                    }
                                    .tag(ScreenType.home.id)
                                ListScreenView()
                                    .tabItem {
                                        Label(ScreenType.list.rawValue, systemImage: ScreenType.list.iconName)
                                    }
                                    .tag(ScreenType.list.id)
                                GoalScreenView()
                                    .tabItem {
                                        Label(ScreenType.goal.rawValue, systemImage: ScreenType.goal.iconName)
                                    }
                                    .tag(ScreenType.goal.id)
                            }
                        }
                    // Transparent overlay to capture taps outside the drawer
                    if globalState.isDrawerOpen {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                globalState.isDrawerOpen = false
                            }
                            .zIndex(98) // Ensure it's behind the drawer
                    }
                }
                
            }
        
    }
}

#Preview {
    MainAppView()
}
