//
//  TemtemListView.swift
//  TemDex
//
//  Created by dabiz on 19/12/2023.
//

import SwiftUI

struct TemtemListView: View {
    
    let viewModel = TemtemListViewModel()
    @State private var temtems: [Temtem] = []
    @State private var temtemDetail: Temtem? = nil
    @State private var viewState: ViewState = .loading
    @State private var showFiltersModal: Bool = false
    
    // Filters
    @State private var searchTerm: String = ""
    @State private var selectedType1: TypeElement = .none
    @State private var selectedType2: TypeElement = .none
    @State private var selectedMinStat: Double = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(16)
            
            switch viewState {
            case .loading:
                loadingView
            case .success:
                temtemListView
            case .error:
                errorView
            }
        }
        .background(Color.background.ignoresSafeArea())
        .task {
            await loadTemtems()
            await loadTraits()
            await loadTechniques()
        }
        .onChange(of: searchTerm) {
            withAnimation(.linear) {
                temtems = filteredTems()
            }
        }
        .onChange(of: [selectedType1, selectedType2], {
            withAnimation(.linear) {
                temtems = filteredTems()
            }
        })
        .onChange(of: selectedMinStat, {
            withAnimation(.linear) {
                temtems = filteredTems()
            }
        })
        .sheet(item: $temtemDetail) { temtem in
            TemtemDetailView(temtem: temtem, viewModel: viewModel)
        }
        .sheet(isPresented: $showFiltersModal) {
            FiltersView(
                selectedType1: $selectedType1,
                selectedType2: $selectedType2,
                selectedMinStat: $selectedMinStat,
                minStat: viewModel.temtems.minTotalStat,
                maxStat: viewModel.temtems.maxTotalStat
            )
            .presentationDetents([.fraction(0.45)])
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            SearchBarView(searchTerm: $searchTerm, promptLabel: searchPrompt)
                .background {
                    Color.background.ignoresSafeArea().opacity(0.9).blur(radius: 5)
                }
            filtersButton
        }
    }
    
    private var loadingView: some View {
        VStack {
            LoadingView()
                .padding(.top, 120)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var temtemListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(temtems) { temtem in
                    Button {
                        temtemDetail = temtem
                    } label: {
                        TemtemRowView(temtem: temtem)
                    }
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .scrollDismissesKeyboard(.interactively)
        .background {
            if temtems.isEmpty {
                noResultsView
            }
        }
    }
    
    private var noResultsView: some View {
        VStack {
            NoResultsView()
                .padding(.top, 120)
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
    
    private var errorView: some View {
        VStack {
            ErrorView(tryAgain: {
                await loadTemtems()
                await loadTraits()
                await loadTechniques()
            })
                .padding(.top, 120)
            Spacer()
        }
    }
    
    private func searchPrompt() -> some View {
        Text("Search ")
            .foregroundStyle(.white.opacity(0.3))
            .font(for: .rubikMedium)
        +
        Text("Temtem")
            .foregroundStyle(.white.opacity(0.3))
            .font(for: .temtemLogo)
            .baselineOffset(-1)
    }
    
    private var filtersImage: String {
        if selectedType1 == .none && selectedType2 == .none && selectedMinStat <= viewModel.temtems.minTotalStat {
            return "line.3.horizontal.decrease.circle"
        } else {
            return "line.3.horizontal.decrease.circle.fill"
        }
    }
    
    private var filtersButton: some View {
        Button {
            hideKeyboard()
            showFiltersModal = true
        } label: {
            Image(systemName: filtersImage)
                .resizable()
                .scaledToFit()
                .frame(height: 24)
                .foregroundStyle(.white)
        }
    }
    
    @MainActor
    private func loadTemtems() async {
        do {
            viewState = .loading
            try await viewModel.loadTemtems()
            withAnimation(.linear) {
                temtems = viewModel.temtems
                selectedMinStat = viewModel.temtems.minTotalStat
            }
            withAnimation(.easeOut) {
                viewState = .success
            }
        } catch {
            print(error)
            withAnimation {
                viewState = .error
            }
        }
    }
    
    @MainActor
    private func loadTraits() async {
        do {
            try await viewModel.loadTraits()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    private func loadTechniques() async {
        do {
            try await viewModel.loadTechniques()
        } catch {
            print(error)
        }
    }
    
    private func filteredTems() -> [Temtem] {
        return viewModel.temtems.filteredBy(name: searchTerm, types: [selectedType1, selectedType2], stat: selectedMinStat)
    }
}

extension TemtemListView {
    enum ViewState {
        case loading
        case success
        case error
    }
}
