//
//  CarsListView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import SwiftUI

struct CarsListView: View {
    
    @ObservedObject private var viewModel: CarsListViewModel
    private let columns = [GridItem(.flexible(), spacing: Spacing._none)]
    
    var body: some View {
        self.contentView {
            GenericList(status: self.viewModel.status) {
                AnyView(Color.red)
            } emptyView: {
                AnyView(Color.red)
            } errorView: { message in
                AnyView(Color.red)
            } cell: { car in
                AnyView(Color.red)
            } refreshable: {
                self.viewModel.getAll()
            }
        }
    }
    
    fileprivate init(viewModel: CarsListViewModel) {
        self.viewModel = viewModel
    }
}

extension CarsListView {
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack { view() }
            .background(.neutral0)
            .onAppear {
                self.viewModel.getAll()
            }
    }
}

extension CarsListView {
    static func build() -> NavigatorScreen {
        let carsService = CarsService()
        let interactor = CarInteractor(carsService: carsService)
        let viewModel = CarsListViewModel(interactor: interactor)
        let view = CarsListView(viewModel: viewModel)
        return NavigatorScreen(view: view)
    }
    
    static func buildMock() -> some View {
        let carsService = CarsServiceMock()
        let interactor = CarInteractor(carsService: carsService)
        let viewModel = CarsListViewModel(interactor: interactor)
        let view = CarsListView(viewModel: viewModel)
        return view
    }
}

#Preview {
    CarsListView.buildMock()
}
