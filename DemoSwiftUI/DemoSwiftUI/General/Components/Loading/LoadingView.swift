//
//  LoadingView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject private var manager = LoadingViewManager.shared
    var body: some View {
        if self.manager.show {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                Spacer()
            }
            .background(.dark.opacity(0.2))
        }
    }
}

final class LoadingViewManager: ObservableObject {
    static let shared = LoadingViewManager()
    @Published var show: Bool = false
    private init() { }
}
