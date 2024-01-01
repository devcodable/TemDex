//
//  TypeCapsuleView.swift
//  TemDex
//
//  Created by dabiz on 25/12/2023.
//

import SwiftUI

struct TypeCapsuleView: View {
    
    let typeElement: TypeElement
    var typeColor: Color {
        typeElement == .toxic ?
        Color.gray :
        Color(for: .type(typeElement))
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text(typeElement.rawValue.capitalized)
                .font(for: .rubikMedium)
                .foregroundStyle(typeColor)
                .offset(x: 6)
            
            Spacer()
        }
        .padding(.vertical, 6)
        .frame(width: 128)
        .overlay {
            Capsule()
                .stroke(typeColor, lineWidth: 2)
        }
        .overlay(alignment: .leading) {
            Image(for: .type(typeElement))
                .resizable()
                .scaledToFit()
                .frame(width: 24)
                .padding(.leading, 8)
        }
    }
}

#Preview {
    TypeCapsuleView(typeElement: .fire)
}
