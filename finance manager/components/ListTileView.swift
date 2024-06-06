//
//  ListTile.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-10.
//

import SwiftUI

struct ListTileView: View {
    var tile: ListTileModel

    var body: some View {
        HStack {
            HStack {
                Image(systemName: tile.image )
                    .foregroundColor(tile.type == .income ? Color.green : Color.red)
                VStack(alignment: .leading) {
                    Text(" \(tile.category)")
                        .font(.headline)
                    Text(" \(tile.comment)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Text(String(tile.type == .income ? "\(removeCommasAndDots(from: tile.amount.abbreviated))" : "-\(removeCommasAndDots(from: tile.amount.abbreviated))"))
                .font(.headline)
                .foregroundColor(tile.type == .income ? Color.green : Color.red)
                .padding(.trailing, 35)
        }
    }
}
