//
//  AmountType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

enum AmountType: Identifiable, CaseIterable {
    var id: Self { self }
    case income
    case expense
}
