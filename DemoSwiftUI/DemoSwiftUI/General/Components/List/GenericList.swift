//
//  GenericList.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import SwiftUI

struct GenericList<Item: Identifiable>: View {
    
    private let columns = [GridItem(.flexible(), spacing: Spacing._none)]
    
    private var status: GenericListStatus<Item> = .loading
    private let cell: (Item) -> AnyView
    
    private var emptyView: (() -> AnyView)?
    private var errorView: ((String) -> AnyView)?
    private var loadingView: (() -> AnyView)?
    private var isRefreshable: (() -> Void)?
    private var onCellSelected: ((Item) -> Void)?
    
    init(status: GenericListStatus<Item>, cell: @escaping (Item) -> AnyView) {
        self.status = status
        self.cell = cell
    }
    
    var body: some View {
        ScrollView {
            switch self.status {
            case .loading:
                self.loadingView?()
            case .empty:
                self.emptyView?()
            case .error(let message):
                self.errorView?(message)
            case .data(let items):
                LazyVGrid(columns: self.columns, spacing: Spacing._md) {
                    ForEach(items) { item in
                        self.cell(item)
                            .onTapGesture {
                                self.onCellSelected?(item)
                            }
                    }
                }
                .padding(Spacing._lg)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(.container, edges: .bottom)
        .conditionalRefreshable(self.isRefreshable)
    }
    
    func onCellSelected(_ value: ((Item) -> Void)?) -> Self {
        var view = self
        view.onCellSelected = value
        return view
    }
    
    func emptyView(_ value: (() -> AnyView)?) -> Self {
        var view = self
        view.emptyView = value
        return view
    }
    
    func errorView(_ value: ((String) -> AnyView)?) -> Self {
        var view = self
        view.errorView = value
        return view
    }
    
    func loadingView(_ value: (() -> AnyView)?) -> Self {
        var view = self
        view.loadingView = value
        return view
    }
    
    func isRefreshable(_ value: (() -> Void)?) -> Self {
        var view = self
        view.isRefreshable = value
        return view
    }
}

fileprivate extension View {
    @ViewBuilder
    func conditionalRefreshable(_ action: (() -> Void)?) -> some View {
        if let action = action {
            self.refreshable { action() }
        } else {
            self
        }
    }
}

enum GenericListStatus<Item: Identifiable> {
    case loading
    case empty
    case error(message: String)
    case data(items: [Item])
}
