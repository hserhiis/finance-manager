//
//  AddNoteButton.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

struct AddNoteButton: View {
    var addToNoteList: () -> Void
    var body: some View {
        Button("Add Note") {
            addToNoteList()
        }
        .font(.custom("add", fixedSize: 20))
        .bold()
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .background(Color.buttonAdd)
        .foregroundColor(Color.white)
        .cornerRadius(3)
    }
}
