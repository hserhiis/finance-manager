//
//  Types.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
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

enum IconType: String, CaseIterable, Identifiable {
    case home = "house.fill"
    case work = "briefcase.fill"
    case shopping = "storefront.fill"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .work: return "Work"
        case .shopping: return "Shopping"
        }
    }
}

enum AmountType: Identifiable, CaseIterable{
    var id: Self {self}
    case income
    case expense
}


enum DateType: Identifiable, CaseIterable {
    var id: Self {self}
    case yearMonthDay
    case monthDay
}

enum DayType: Identifiable, CaseIterable {
    var id: Self {self}
    case today
    case yesterday
    case beforeYesterday
    
    var day: String {
        switch self {
        case .today: return "Today"
        case .yesterday: return "Yesterday"
        case .beforeYesterday: return "Before Yesterday"
        }
    }
}
enum ScreenType: String, CaseIterable {
    case home = "Home"
    case list = "List"
    case goal = "Goal"
    case settings = "Settings"
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .list:
            return "list.bullet.clipboard.fill"
        case .goal:
            return "gear"
        case .settings:
            return "gearshape.fill"
        }
    }
    
    var id: Int {
        switch self {
        case .home:
            return 0
        case .list:
            return 1
        case .goal:
            return 2
        case .settings:
            return 3
        }
    }
}
