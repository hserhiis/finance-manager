//
//  TextFieldCustomView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct TextFieldCustomView: View {
    @Binding var amount: String
    var placeholder: String
    var body: some View {
        TextField(placeholder, text: $amount)
            .padding()
            .background(Color.gray)
            
            
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var amount: String = ""
    
    static var previews: some View {
        TextFieldCustomView(amount: $amount, placeholder: "Enter amount")
    }
}
