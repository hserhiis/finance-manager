//
//  TabType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

enum TabType {
    case income
    case expenses
    case balance
    
    var title: String {
        switch self {
        case .income: return "Income"
        case .expenses: return "Expenses"
        case .balance: return "Balance"
        }
    }
    
    var color: Color {
        switch self {
        case .income: return .green
        case .expenses: return .red
        case .balance: return .blue
        }
    }
    
    var id: Int {
        switch self {
        case .income: return 0
        case .expenses: return 1
        case .balance: return 2
        }
    }
}
