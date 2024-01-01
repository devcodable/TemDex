//
//  ContentView.swift
//  TemDex
//
//  Created by dabiz on 19/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TemtemListView()
        }
        .background(Color.background)
    }
}
