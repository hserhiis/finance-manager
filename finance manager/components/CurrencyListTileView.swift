//
//  CurrencyListTileView.swift
//  finance manager
//
//  Created by Serhii Shapovalov on 2024-05-12.
//

import SwiftUI

struct CurrencyListTileView: View {
    var key: String
    var value: String
    
    
    var body: some View {
        HStack{
            Text(value)
            Spacer()
            Text(key)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}
