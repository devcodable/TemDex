//
//  FiltersView.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showPopover1: Bool = false
    @State private var showPopover2: Bool = false
    
    @Binding var selectedType1: TypeElement
    @Binding var selectedType2: TypeElement
    @Binding var selectedMinStat: Double
    let minStat: Double
    let maxStat: Double
    
    init(
        selectedType1: Binding<TypeElement>,
        selectedType2: Binding<TypeElement>,
        selectedMinStat: Binding<Double>,
        minStat: Double,
        maxStat: Double
    ) {
        self._selectedType1 = selectedType1
        self._selectedType2 = selectedType2
        self._selectedMinStat = selectedMinStat
        self.minStat = minStat
        self.maxStat = maxStat
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            typesFilter
                .padding(.bottom, 16)
            
            statFilter
            
            Spacer()
            
            clearButton
        }
        .padding(.bottom, 16)
        .padding(.top, 32)
        .padding(.horizontal, 48)
        .background(Color.background)
        .closeModalButton {
            dismiss()
        }
    }
    
    private var typesFilter: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Text("Types")
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                Spacer()
            }
            HStack(spacing: 0) {
                capsuleType(for: .type1)
                .popover(isPresented: $showPopover1, content: {
                    typesView(for: .type1)
                })
                
                Spacer()
                
                capsuleType(for: .type2)
                .popover(isPresented: $showPopover2, content: {
                    typesView(for: .type2)
                })
            }
        }
        .presentationDragIndicator(.visible)
    }
    
    private var statFilter: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("Total stats")
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                Spacer()
            }
            
            Text("\(selectedMinStat.toInt())")
                .font(for: .rubikBold, size: 18)
                .foregroundStyle(.white)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            Slider(value: $selectedMinStat, in: minStat...maxStat) {
                Text("\(selectedMinStat.toInt())")
            } minimumValueLabel: {
                Button {
                    selectedMinStat -= 1
                } label: {
                    Text("\(minStat.toInt())")
                        .font(for: .rubikMedium)
                        .foregroundStyle(.white)
                }
            } maximumValueLabel: {
                Button {
                    selectedMinStat += 1
                } label: {
                    Text("\(maxStat.toInt())")
                        .font(for: .rubikMedium)
                        .foregroundStyle(.white)
                }
            }
            .tint(Color.crystal)
        }
    }
    
    private func capsuleType(for typeNumber: TypeNumber) -> some View {
        var placeHolder: some View {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(typeNumber.value)
                    .font(for: .rubikMedium)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.vertical, 6)
            .frame(width: 128)
            .overlay {
                Capsule()
                    .stroke(.white, lineWidth: 2)
            }
        }
        
        return Button {
            switch typeNumber {
            case .type1:
                showPopover1 = true
            case .type2:
                showPopover2 = true
            }
        } label: {
            switch typeNumber {
            case .type1:
                if selectedType1 != .none {
                    TypeCapsuleView(typeElement: selectedType1)
                        .onTapGesture {
                            showPopover1 = true
                        }
                        .onLongPressGesture(minimumDuration: 0.1) {
                            selectedType1 = .none
                        }
                } else {
                    placeHolder
                }
            case .type2:
                if selectedType2 != .none {
                    TypeCapsuleView(typeElement: selectedType2)
                        .onTapGesture {
                            showPopover2 = true
                        }
                        .onLongPressGesture(minimumDuration: 0.1) {
                            selectedType2 = .none
                        }
                } else {
                    placeHolder
                }
            }
        }
    }
    
    private func typesView(for typeNumber: TypeNumber) -> some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                ForEach(TypeElement.firstHalf, id: \.self) { type in
                    Button {
                        withAnimation {
                            switch typeNumber {
                            case .type1:
                                selectedType1 = type
                                showPopover1 = false
                            case .type2:
                                selectedType2 = type
                                showPopover2 = false
                            }
                        }
                    } label: {
                        TypeCapsuleView(typeElement: type)
                    }
                }
            }
            VStack(spacing: 12) {
                ForEach(TypeElement.secondHalf, id: \.self) { type in
                    Button {
                        withAnimation {
                            switch typeNumber {
                            case .type1:
                                selectedType1 = type
                                showPopover1 = false
                            case .type2:
                                selectedType2 = type
                                showPopover2 = false
                            }
                        }
                    } label: {
                        TypeCapsuleView(typeElement: type)
                    }
                }
            }
        }
        .padding(16)
        .scrollIndicators(.hidden)
        .background(Color.background)
        .presentationCompactAdaptation(.popover)
    }
    
    
    private var clearButton: some View {
        Button {
            withAnimation {
                selectedType1 = .none
                selectedType2 = .none
                selectedMinStat = minStat
            }
        } label: {
            Text("Clear filters")
                .font(for: .rubikMedium, size: 18)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}

extension FiltersView {
    private enum TypeNumber: String {
        case type1, type2
        var value: String {
            switch self {
            case .type1: "Type 1"
            case .type2: "Type 2"
            }
        }
    }
}
