//
//  TemtemRowView.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

struct TemtemRowView: View {
    let temtem: Temtem
    let evolutionText: String?
    let evolutionTextColor: Color
    @State private var imageWidth: CGFloat = 106
    
    init(
        temtem: Temtem,
        evolutionText: String? = nil,
        evolutionTextColor: Color = .white
    ) {
        self.temtem = temtem
        self.evolutionText = evolutionText
        self.evolutionTextColor = evolutionTextColor
    }
    
    
    var body: some View {
        ZStack {
            temtemImage
            
            temtemFrame
            
            evolutionInfo
                .padding(.trailing, 12)
                .padding(.top, 8)
            
            temtemInfo
                .padding(.leading, imageWidth + 4)
                .padding(.top, 16)
        }
    }
    
    var asyncImage: some View {
        CachedAsyncImage(url: URL(string: temtem.portraitUrl), urlCache: .portraitCache) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image(.tateruPortrait)
                .resizable()
                .scaledToFit()
        }
    }
    
    var temtemImage: some View {
        HStack(spacing: 0) {
            Image(.photoFrame)
                .renderingMode(.template)
                .foregroundStyle(Color.background)
                .overlay {
                    asyncImage
                        .mask {
                            Image(.photoFrame)
                        }
                        .scaleEffect(0.92)
                }
                .scaleEffect(0.85)
                .readSize()
                .onPreferenceChange(SizePreferenceKey.self, perform: { size in
                    self.imageWidth = size.width
                })
            Spacer()
        }
    }
    
    var temtemFrame: some View {
        HStack {
            Image(.frame)
                .resizable()
                .scaledToFit()
        }
    }
    
    var temtemInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(temtem.name)
                .font(for: .rubikBold)
                .foregroundStyle(.white)
            
            HStack(alignment: .center, spacing: 0){
                Text(temtem.number)
                    .font(for: .rubik)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                ForEach(temtem.types, id: \.self) { type in
                    Image(for: .type(type))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
            }
            .padding(.trailing, 16)
        }
    }
    
    @ViewBuilder
    var evolutionInfo: some View {
        if let evolutionText {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Spacer()
                    Text(evolutionText)
                        .font(for: .rubikMedium)
                        .foregroundStyle(evolutionTextColor)
                }
                
                Spacer()
            }
        }
    }
}
