//
//  TemtemDetailView.swift
//  TemDex
//
//  Created by dabiz on 23/12/2023.
//

import SwiftUI
import GIFImage

struct TemtemDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var infoView: InfoView = .info
    @State private var shouldScrollToTop: Bool = false
    @State private var selectedTrait: Trait? = nil
    @State private var selectedTechnique: Technique? = nil
    @State private var techniqueSource: String = ""
    
    @State private var temtem: Temtem
    let viewModel: TemtemListViewModel
    
    var evolutions: [Temtem] {
        temtem.getEvolutions(from: viewModel.temtems)
    }
    
    init(temtem: Temtem, viewModel: TemtemListViewModel) {
        self._temtem = State(initialValue: temtem)
        self.viewModel = viewModel
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.tateruTeal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont(name: "Temfont-Regular", size: 20) ?? UIFont.systemFont(ofSize: 16)], for: .normal)
    }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    TemtemRenderView(temtem: temtem)
                        .id(1)
                    
                    Group {
                        basicInfo
                        
                        segmentedControl
                            .padding(.vertical, 16)
                        
                        switch infoView {
                        case .info:
                            temtemDetails
                        case .techniques:
                            traitsAndTechniques
                        }
                    }
                    .animation(.linear(duration: 0.5), value: infoView)
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .padding(.bottom, 16)
                .background(Color.background)
            }
            .easterBackground()
            .onChange(of: shouldScrollToTop) {
                withAnimation {
                    reader.scrollTo(1, anchor: .top)
                }
            }
            .sheet(item: $selectedTrait, content: { trait in
                TraitModalView(trait: trait, temtem: temtem)
                    .closeModalButton {
                        selectedTrait = nil
                    }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
            })
            .sheet(item: $selectedTechnique, content: { technique in
                TechniqueModalView(technique: technique, sourceText: techniqueSource)
                    .closeModalButton {
                        selectedTechnique = nil
                    }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
            })
            .closeModalButton {
                dismiss()
            }
        }
    }
    
    private var segmentedControl: some View {
        Picker(selection: $infoView) {
            Text("Temtem info")
                .font(for: .rubikBold, size: 18)
                .foregroundStyle(.white)
                .tag(InfoView.info)
            
            Text("Techniques")
                .font(for: .rubikBold, size: 18)
                .foregroundStyle(.white)
                .tag(InfoView.techniques)
        } label: {
            //
        }
        .pickerStyle(.segmented)
    }
    
    private var basicInfo: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(temtem.number)
                .foregroundStyle(.gray)
                .font(for: .rubikMedium, size: 18)
            
            Text(temtem.name)
                .foregroundStyle(.white)
                .font(for: .rubikBold, size: 32)
                .padding(.top, 6)
            
            HStack(spacing: 12) {
                ForEach(temtem.types, id: \.self) { type in
                    TypeCapsuleView(typeElement: type)
                }
            }
            .padding(.top, 12)
            
            Text(temtem.gameDescription)
                .font(for: .rubik)
                .lineSpacing(1.2)
                .foregroundStyle(.white)
                .padding(.top, 16)
            
            heightWeightInfo
                .padding(.top, 12)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var heightWeightInfo: some View {
        HStack(spacing: 16) {
            Group {
                Text("Height:  ")
                    .font(for: .rubikBold)
                +
                Text("\(temtem.height)cm")
                    .font(for: .rubik)
                
                Text("Weight:  ")
                    .font(for: .rubikBold)
                +
                Text("\(temtem.weight)kg")
                    .font(for: .rubik)
            }
            .foregroundStyle(.white)
            Spacer()
        }
    }
    
    private var temtemDetails: some View {
        VStack(alignment: .leading, spacing: 0) {
            StatsView(stats: temtem.stats, types: temtem.types)
            
            TypeTableView(types: temtem.types)
                .padding(.top, 24)
            
            TemtemEvolutionsView(evolutions: evolutions, temtem: $temtem, shouldScrollToTop: $shouldScrollToTop)
                .padding(.top, 24)
            
            locations
                .padding(.top, 24)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var traitsAndTechniques: some View {
        VStack(alignment: .leading, spacing: 0) {
            TraitsView(
                temtem: temtem,
                traits: temtem.getTraits(from: viewModel.traits),
                selectedTrait: { trait in
                    selectedTrait = trait
                })
            
            TechniquesView(
                temtem: temtem,
                techniques: temtem.getTechniques(from: viewModel.techniques),
                selectedTechnique: { temtemTechnique, technique in
                    techniqueSource = temtemTechnique.sourceText
                    selectedTechnique = technique
                }
            )
                .padding(.top, 24)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var cantBeCatchedText: Text {
        Text("This ")
            .font(for: .rubik)
            .foregroundStyle(.white)
        +
        Text("Temtem")
            .font(for: .temtemLogo, size: 18)
            .foregroundStyle(.white)
            .baselineOffset(-1)
        +
        Text(" can't be catched.")
            .font(for: .rubik)
            .foregroundStyle(.white)
    }
    
    private var locations: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Locations")
                .font(for: .rubikBold, size: 24)
                .foregroundStyle(.white)
            
            if !temtem.locations.isEmpty {
                ForEach(temtem.locations) { location in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(location.location) - \(location.island)")
                            .font(for: .rubikMedium)
                            .foregroundStyle(.white)
                        Group {
                            Text("Frequency:  \(location.frequency)")
                            
                            Text("Levels:  \(location.level)")
                        }
                        .font(for: .rubikMedium)
                        .foregroundStyle(.gray)
                    }
                    .padding(.top, 12)
                }
            } else {
                cantBeCatchedText
                    .padding(.top, 12)
            }
        }
    }
}

extension TemtemDetailView {
    enum InfoView {
        case info, techniques
    }
}
