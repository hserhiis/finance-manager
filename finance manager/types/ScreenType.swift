//
//  ScreenType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//

import SwiftUI

enum ScreenType: String, CaseIterable {
    case home = "Home"
    case list = "List"
    case notes = "Notes"
    case settings = "Settings"
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .list: return "list.bullet.clipboard.fill"
        case .notes: return "doc.badge.plus"
        case .settings: return "gearshape.fill"
        }
    }
    
    var id: Int {
        switch self {
        case .home: return 0
        case .list: return 1
        case .notes: return 2
        case .settings: return 3
        }
    }
}
