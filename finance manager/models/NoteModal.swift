//
//  NoteModal.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-31.
//

import Foundation

struct NoteModal: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var category: String
    var isChecked: Bool = false
}
