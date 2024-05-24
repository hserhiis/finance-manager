//
//  finance_managerApp.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

@main
struct finance_managerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                ListView()
                    .tabItem {
                        Label("List", systemImage: "list.bullet.clipboard.fill")
                    }
                    
                GoalView()
                    .tabItem {
                        Label("Goal", systemImage: "gear")
                    }
            }
            .environmentObject(GlobalState())
        }
        
    }
        
}
