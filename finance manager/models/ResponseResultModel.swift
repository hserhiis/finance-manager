//
//  ResponseResultModel.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-15.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var title: String
    var subtitle: String
}
