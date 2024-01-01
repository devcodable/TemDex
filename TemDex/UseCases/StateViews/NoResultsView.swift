//
//  NoResultsView.swift
//  TemDex
//
//  Created by dabiz on 24/12/2023.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack {
            noResultsText
                .frame(height: 60)
            
            noResultsImage
                .padding(.top, 86)
        }
    }
    
    private var noResultsText: Text {
        Text("No ")
            .font(for: .rubikBold, size: 24)
            .foregroundStyle(.white)
        +
        Text("Temtem")
            .font(for: .temtemLogo, size: 28)
            .foregroundStyle(.white)
            .baselineOffset(-1.5)
        +
        Text(" found :/")
            .font(for: .rubikBold, size: 24)
            .foregroundStyle(.white)
    }
    
    private var noResultsImage: some View {
        Image(.barnshe)
            .resizable()
            .scaledToFit()
            .frame(height: 220)
    }
}

#Preview {
    NoResultsView()
        .background(Color.background)
}
