//
//  SocialButton.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-11.
//

import SwiftUI

struct SocialButton: View {
    var icon: ImageResource
    var text: String
    var body: some View {
        HStack(alignment: .center) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.trailing, 8)
            Text(text)
                .font(.title2)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.textField)
        .cornerRadius(3.0)
    }
}
