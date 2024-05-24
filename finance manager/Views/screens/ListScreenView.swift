//
//  ListView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var globalState: GlobalState
    var body: some View {
        List {
            ForEach(sortedEntries, id: \.key) { date, tiles in
                Section(header: Text(date)){
                    ForEach(tiles, id: \.self){ tile in
                        HStack {
                            Image(systemName: tile.image )
                            VStack {
                                Text(" \(tile.category)")
                                    .font(.headline)
                                Text(" \(tile.comment)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(String(tile.type == .income ? "\(tile.amount)" : "-\(tile.amount)"))
                                .font(.headline)
                                .foregroundColor(tile.type == .income ? Color.green : Color.red)
                            Spacer()
                            
                        }
                    }
                }
            }
            
        }
    }
    
    
    private var sortedEntries: [(key: String, value: [ListTile])] {
        globalState.listView.sorted {$0.key < $1.key}
    }
}

#Preview {
    ListView()
        .environmentObject(GlobalState())
}
