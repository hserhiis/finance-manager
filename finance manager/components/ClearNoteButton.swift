//
//  ClearNoteButton.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

struct ClearNoteButton: View {
    var clearNote: () -> Void
    var body: some View {
        Button {
            clearNote()
        } label: {
            Image(systemName: "clear.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
        }
        .padding(.trailing, 10)
    }
}
