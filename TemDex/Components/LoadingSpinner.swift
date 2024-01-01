//
//  LoadingSpinner.swift
//  TemDex
//
//  Created by dabiz on 23/12/2023.
//

import SwiftUI

struct LoadingSpinner: View {
    // MARK: - Properties
    @State private var degree: Int = 270
    @State private var spinnerLength = 0.6
    
    var body: some View {
        
        Circle()
            .trim(from: 0.0, to: spinnerLength)
            .stroke(colorGradient, style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin:.round))
            .animation(.easeIn(duration: 1.5).repeatForever(autoreverses: true), value: degree)
            .frame(width: 60, height: 60)
            .rotationEffect(Angle(degrees: Double(degree)))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: spinnerLength)
            .onAppear{
                degree = 270 + 360
                spinnerLength = 0
            }
    }
    
    private var colorGradient: LinearGradient {
        LinearGradient(
            colors: [.tateruGray, .tateruDarkGray, .tateruGreen, .tateruTeal],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    LoadingSpinner()
}
