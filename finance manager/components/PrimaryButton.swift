//
//  PrimaryButton.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(.vertical, 20)
            .frame(minWidth: 100, maxWidth: 300)
            .foregroundColor(Color.white)
            .background(Color.buttonAdd)
            .cornerRadius(35)
            .padding(.horizontal, 20)
        
    }
}
