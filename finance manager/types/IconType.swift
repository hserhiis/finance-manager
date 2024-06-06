//
//  IconType.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-06-02.
//
import SwiftUI

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
