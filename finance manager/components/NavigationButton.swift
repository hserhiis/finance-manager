//
//  NavigationButton.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

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
