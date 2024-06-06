//
//  NotesTextFields.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

struct NotesTextFields: View {
    @Binding var text: String
    @Binding var category: String
    var body: some View {
        TextFieldCustomView(text: $text, placeholder: "Enter Note")
        TextFieldCustomView(text: $category, placeholder: "Enter Category")
    }
}
