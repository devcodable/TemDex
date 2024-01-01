//
//  AsyncButton.swift
//  TemDex
//
//  Created by dabiz on 24/12/2023.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    var body: some View {
        Button(action: {
            isPerformingTask = true
            Task {
                await action()
                isPerformingTask = false
            }
        }, label: {
            label().opacity(isPerformingTask ? 0.5 : 1)
        })
        .buttonStyle(.bordered)
        .disabled(isPerformingTask)
    }
}
