//
//  ListTile.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import Foundation

struct ListTile: Identifiable, Hashable {
    var id = UUID()
    var amount: Double
    var comment: String
    var category: String
    var image: String
    var type: AmountType
}
