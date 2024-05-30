//
//  TextFieldCustomView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct TextFieldCustomView: View {
    @Binding var text: String
    var placeholder: String
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.textField)
            .foregroundColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        TextFieldCustomView(text: $text, placeholder: "Enter amount")
    }
}
