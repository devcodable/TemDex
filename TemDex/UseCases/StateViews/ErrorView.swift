//
//  ErrorView.swift
//  TemDex
//
//  Created by dabiz on 24/12/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let tryAgain: () async -> Void
    
    var body: some View {
        VStack {
            errorText
                .frame(height: 60)
            
            errorImage
                .padding(.top, 66)
            
            tryAgainButton
                .padding(.top, 32)
        }
    }
    
    private var errorText: Text {
        Text("Oops, something went wrong")
            .font(for: .rubikBold, size: 24)
            .foregroundStyle(.white)
    }
    
    private var errorImage: some View {
        Image(.oree)
            .resizable()
            .scaledToFit()
            .frame(height: 220)
    }
    
    private var tryAgainButton: some View {
        AsyncButton {
            await tryAgain()
        } label: {
            Text("Try again")
                .font(for: .rubikMedium, size: 18)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ErrorView(tryAgain: { })
}
