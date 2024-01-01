//
//  StatsView.swift
//  TemDex
//
//  Created by dabiz on 25/12/2023.
//

import SwiftUI

struct StatsView: View {
    
    @State private var barWidth: CGFloat = .zero
    
    let stats: [StatElement]
    let types: [TypeElement]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Stats")
                .font(for: .rubikBold, size: 24)
                .foregroundStyle(.white)
                .padding(.bottom, 12)
            
            statsView
        }
    }
    
    private var statsView: some View {
        
        ForEach(stats, id: \.self) { stat in
            HStack {
                Text(stat.key.uppercased())
                    .font(for: .rubikMedium, size: 14)
                    .foregroundStyle(.white)
                    .frame(width: 50, alignment: .leading)
                
                Text("\(stat.value)")
                    .font(for: .rubikMedium, size: 14)
                    .foregroundStyle(.gray)
                    .frame(width: 40)
                
                RoundedRectangle(cornerRadius: 6)
                    .frame(maxWidth: .infinity, maxHeight: 12)
                    .foregroundStyle(.black.opacity(0.5))
                    .readSize()
                    .onPreferenceChange(SizePreferenceKey.self, perform: { size in
                        self.barWidth = size.width
                    })
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(
                                width: barWidth * (stat.value.toDouble()/stat.maxValue.toDouble()),
                                height: 12
                            )
                            .foregroundStyle(
                                LinearGradient(
                                    colors: types.map { Color(for: .type($0)) },
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                
            }
            .frame(height: 24)
        }
    }
}
