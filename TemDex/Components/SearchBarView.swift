//
//  SearchBarView.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

struct SearchBarView<Content>: View, KeyboardReadable where Content: View {
    
    @State private var isKeyboardVisible: Bool = false
    
    @Binding var searchTerm: String
    let promptLabel: () -> Content
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Group {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.leading, 6)
                    
                    searchField
                }
                .padding(.vertical, 8)
            }
            .background(content: {
                Color.gray.opacity(0.2).blur(radius: 3).clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .frame(maxWidth: .infinity)
            
            cancelButton
        }
    }
    
    private var searchField: some View {
        TextField(text: $searchTerm, label: {
            promptLabel()
        })
        .autocorrectionDisabled()
        .font(for: .rubik, size: 18)
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            withAnimation {
                isKeyboardVisible = newIsKeyboardVisible
            }
        }
        .submitLabel(.search)
        .foregroundStyle(.white)
        .background(.clear)
        .padding(.trailing, 24)
        .overlay(alignment: .trailing) {
            deleteIcon
        }
    }
    
    @ViewBuilder
    private var cancelButton: some View {
        if isKeyboardVisible {
            Button {
                withAnimation(.linear) {
                    searchTerm = ""
                }
                hideKeyboard()
            } label: {
                Text("Cancel")
                    .font(for: .rubikMedium)
                    .foregroundStyle(.white)
            }
            .padding(.leading, 4)
            .transition(.asymmetric(insertion: .push(from: .trailing), removal: .push(from: .leading)))
        }
    }
    
    @ViewBuilder
    private var deleteIcon: some View {
        if !searchTerm.isEmpty {
            Button {
                withAnimation(.linear) {
                    searchTerm = ""
                }
            } label: {
                Image(systemName: "x.circle.fill")
            }
            .padding(.trailing, 6)
            .foregroundStyle(.white.opacity(0.3))
            .transition(.scale)
        }
    }
}

//#if DEBUG
//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
//#endif
