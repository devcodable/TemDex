//
//  LoadingView.swift
//  TemDex
//
//  Created by dabiz on 23/12/2023.
//

import SwiftUI

struct LoadingView: View {
    @State private var bounceHeight: BounceHeight? = nil
    
    var body: some View {
        VStack {
            LoadingSpinner()
            
            loadingImage
                .padding(.top, 96)
        }
    }
    
    private var loadingImage: some View {
        Image(.tateru)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .offset(x: -8, y: bounceHeight?.associatedOffset ?? 0)
            .onAppear {
                bounceAnimation()
                Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { _ in
                    bounceAnimation()
                })
            }
    }
    
    private func bounceAnimation() {
        withAnimation(Animation.easeOut(duration: 0.3).delay(0)) {
            bounceHeight = .up80
        }
        withAnimation(Animation.easeInOut(duration: 0.04).delay(0)) {
            bounceHeight = .up80
        }
        withAnimation(Animation.easeIn(duration: 0.3).delay(0.34)) {
            bounceHeight = .base
        }
        withAnimation(Animation.easeOut(duration: 0.2).delay(0.64)) {
            bounceHeight = .up40
        }
        withAnimation(Animation.easeIn(duration: 0.2).delay(0.84)) {
            bounceHeight = .base
        }
        withAnimation(Animation.easeOut(duration: 0.1).delay(1.04)) {
            bounceHeight = .up10
        }
        withAnimation(Animation.easeIn(duration: 0.1).delay(1.14)) {
            bounceHeight = .none
        }
    }
}


private enum BounceHeight {
    case up80, up40, up10, base
    var associatedOffset: Double {
        switch self {
        case .up80:
            return -80
        case .up40:
            return -40
        case .up10:
            return -10
        case .base:
            return 0
        }
    }
}

#Preview {
    LoadingView()
}
