//
//  CustomProgressBarView.swift
//  TemDex
//
//  Created by dabiz on 25/12/2023.
//

import SwiftUI

struct CustomProgressBarView: View {
    
    let value: Int
    let total: Int
    var fraction: Double {
        value.toDouble()/total.toDouble()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(.gray)
            .frame(maxWidth: .infinity, maxHeight: 12)
    }
}
