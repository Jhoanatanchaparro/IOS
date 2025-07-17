//
//  GenericList.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import SwiftUI

struct GenericList<T: Identifiable>: View {
    private let columns = [GridItem(.flexible(), spacing: Spacing._none)]
    var status: Status = .loading
    let loadingView: () -> AnyView
    let emptyView: () -> AnyView
    let errorView: (String) -> AnyView
    let cell: (T) -> AnyView
    let refreshable: (() -> Void)?
    
    var body: some View {
        ScrollView {
            switch self.status {
            case .loading:
                self.loadingView()
            case .empty:
                self.emptyView()
            case .error(let message):
                self.errorView(message)
            case .data(let items):
                LazyVGrid(columns: self.columns, spacing: Spacing._md) {
                    ForEach(items) { item in
                        self.cell(item)
                    }
                }
                .padding(Spacing._lg)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(.container, edges: .bottom)
        .refreshable {
            self.refreshable?()
        }
    }
    
    enum Status {
        case loading
        case empty
        case error(message: String)
        case data(items: [T])
    }
}

