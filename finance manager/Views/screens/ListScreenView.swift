//
//  ListView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-09.
//

import SwiftUI

struct ListScreenView: View {
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        List {
            ForEach(sortedEntries, id: \.key) { date, tiles in
                Section(header: Text(date)){
                    ForEach(tiles, id: \.self){ tile in
                        ListTileView(tile: tile) // Corrected to ListTileView
                    }
                }
            }
        }
        
    }
    
    private var sortedEntries: [(key: String, value: [ListTileModel])] {
        return globalState.listView.sorted { $0.key > $1.key }
    }


}
