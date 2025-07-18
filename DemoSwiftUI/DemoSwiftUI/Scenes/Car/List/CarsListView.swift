//
//  CarsListView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import SwiftUI

struct CarsListView: View {
    
    @ObservedObject private var viewModel: CarsListViewModel
    
    var body: some View {
        self.contentView {
            GenericList(status: self.viewModel.status) { item in
                AnyView(CarViewCell(car: item))
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
        let carsService = CarsService()
        let interactor = CarInteractor(carsService: carsService)
        let viewModel = CarsListViewModel(interactor: interactor)
        let view = CarsListView(viewModel: viewModel)
        return view
    }
}

#Preview {
    CarsListView.buildMock()
}
