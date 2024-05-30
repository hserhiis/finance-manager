//
//  ButtonDrawer.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct ButtonDrawer: View {
    var state: GlobalState
    var body: some View {
        HStack{
            
            // Toggle button for the drawer
            Button(action: {
                state.isDrawerOpen.toggle()
                print(state.isDrawerOpen)
            }) {
                Image(systemName: "line.3.horizontal")
                    .padding()
            }
            Spacer()
        }
    }
}
