//
//  DateType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

enum DateType: Identifiable, CaseIterable {
    var id: Self { self }
    case yearMonthDay
    case monthDay
}
