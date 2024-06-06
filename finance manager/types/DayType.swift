//
//  DayType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

enum DayType: Identifiable, CaseIterable {
    var id: Self { self }
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
