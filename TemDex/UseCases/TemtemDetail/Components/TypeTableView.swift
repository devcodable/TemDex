//
//  TypeTableView.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import SwiftUI

struct TypeTableView: View {
    
    let types: [TypeElement]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            resistances
            weaknesses
        }
    }
    
    @ViewBuilder
    private var resistances: some View {
        if !types.x025.isEmpty || !types.x05.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Resistances")
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                
                buildTypesRow(
                    typesArray: types.x025,
                    multiplier: "x1/4",
                    multiplierColor: Color.wind
                )
                buildTypesRow(
                    typesArray: types.x05,
                    multiplier: "x1/2",
                    multiplierColor: Color.nature
                )
            }
        }
    }
    
    @ViewBuilder
    private var weaknesses: some View {
        if !types.x2.isEmpty || !types.x4.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Weaknesses")
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                
                buildTypesRow(
                    typesArray: types.x2,
                    multiplier: "x2",
                    multiplierColor: Color.fire,
                    multiplierSize: 14
                )
                buildTypesRow(
                    typesArray: types.x4,
                    multiplier: "x4",
                    multiplierColor: Color.crystal,
                    multiplierSize: 14
                )
            }
        }
    }
    
    @ViewBuilder
    private func buildTypesRow(
        typesArray: [TypeElement],
        multiplier: String, 
        multiplierColor: Color,
        multiplierSize: CGFloat = 12
    ) -> some View {
        if !typesArray.isEmpty {
            HStack(alignment: .center, spacing: 12) {
                Image(.photoFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 42)
                    .overlay(alignment: .center) {
                        Text(multiplier)
                            .font(for: .typewriter, size: multiplierSize)
                            .foregroundStyle(multiplierColor)
                    }
                    .padding(.trailing, 6)
                
                ForEach(typesArray, id: \.self) { type in
                    Image(.photoFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 36)
                        .overlay(alignment: .center) {
                            Image(for: .type(type))
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                        }
                }
            }
        }
    }
}
