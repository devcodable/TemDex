//
//  TemtemRenderView.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import SwiftUI
import GIFImage

struct TemtemRenderView: View {
    
    let temtem: Temtem
    
    @State private var isLumaSelected: Bool = false
    @State private var isGifSelected: Bool = false
    
    // Gif variables
    @State var placeholder = UIImage(systemName: "photo.circle.fill")!
    @State var animate: Bool = true
    @State var loop: Bool = true
    
    var body: some View {
        temtemRender
            .overlay(alignment: .bottom) {
                HStack(alignment: .bottom) {
                    gifButton
                    Spacer()
                    lumaButton
                        .offset(y: 2)
                }
                .padding(.bottom, 12)
                .padding(.horizontal, 16)
            }
    }
    
    private var temtemRender: some View {
        HStack {
            Spacer()
            Group {
                if !isGifSelected {
                    temtemImage
                } else {
                    temtemGif
                }
            }
            .scaledToFit()
            .frame(height: 256)
            .padding(.top, 48)
            .padding(.bottom, 32)
            .padding(.horizontal, 16)
            .shadow(color: Color.background, radius: 12)
            Spacer()
        }
        .background(
            photoGradient
        )
    }
    
    private var temtemErrorImage: some View {
        VStack {
            Text("Oops, image not found")
                .font(for: .rubikBold, size: 18)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .foregroundStyle(.white)
                .padding(.bottom, 16)
            Image(.oree)
                .resizable()
                .scaledToFit()
        }
    }
    
    @ViewBuilder
    private var temtemImage: some View {
        if isLumaSelected {
            if !temtem.temtemLumaImageUrl.isEmpty,
               temtem.temtemLumaImageUrl.hasSuffix(".png") || temtem.temtemLumaImageUrl.hasSuffix(".jpg") || temtem.temtemLumaImageUrl.hasSuffix(".jpeg"),
               let url = URL(string: temtem.temtemLumaImageUrl) {
                
                CachedAsyncImage(
                    url: url,
                    urlCache: .imageCache
                ) { image in
                    image
                        .resizable()
                } placeholder: {
                    LoadingSpinner()
                }
            } else {
                temtemErrorImage
            }
        } else {
            if !temtem.temtemImageUrl.isEmpty,
               temtem.temtemImageUrl.hasSuffix(".png") || temtem.temtemImageUrl.hasSuffix(".jpg") || temtem.temtemImageUrl.hasSuffix(".jpeg"),
               let url = URL(string: temtem.temtemImageUrl) {
                CachedAsyncImage(
                    url: url,
                    urlCache: .imageCache
                ) { image in
                    image
                        .resizable()
                } placeholder: {
                    LoadingSpinner()
                }
            } else {
                temtemErrorImage
            }
        }
    }
    
    @ViewBuilder
    private var temtemGif: some View {
        if !isLumaSelected {
            GIFImage(
                url: temtem.temtemGifUrl,
                animate: $animate,
                loop: $loop,
                errorImage: nil,
                frameRate: .dynamic) { _ in
                    //
                }
        } else {
            GIFImage(
                url: temtem.temtemLumaGifUrl,
                animate: $animate,
                loop: $loop,
                errorImage: nil,
                frameRate: .dynamic) { _ in
                    //
                }
        }
    }
    
    private var photoGradient: LinearGradient {
        LinearGradient(
            colors: temtem.types.map { Color(for: .type($0)) },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    @ViewBuilder
    private var lumaButton: some View {
        if !temtem.temtemLumaImageUrl.isEmpty,
           temtem.temtemLumaImageUrl.hasSuffix(".png") || temtem.temtemLumaImageUrl.hasSuffix(".jpg") || temtem.temtemLumaImageUrl.hasSuffix(".jpeg") {
            Button {
                isLumaSelected.toggle()
            } label: {
                Image(isLumaSelected ? .lumaIconSelected : .lumaIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            }
        }
    }
    @ViewBuilder
    private var gifButton: some View {
        if !temtem.temtemGifUrl.isEmpty {
            Button {
                isGifSelected.toggle()
            } label: {
                HStack {
                    Text("GIF")
                        .font(for: .rubikBold, size: 18)
                        .foregroundStyle(isGifSelected ? .white : Color.background)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                }
                .background(isGifSelected ? Color.background : .white.opacity(0.8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.background, lineWidth: 6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}
