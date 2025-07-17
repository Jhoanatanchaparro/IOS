//
//  CarsListViewModel.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 16/07/25.
//

import Foundation
import Combine

class CarsListViewModel: ObservableObject {
    
    @Published private(set) var status: GenericList<Car>.Status = .loading
    
    private let interactor: CarInteractorProtocol
    private var task: AnyCancellable?
    
    init(interactor: CarInteractorProtocol) {
        self.interactor = interactor
    }
    
    deinit { self.task?.cancel() }
}

extension CarsListViewModel {
    func getAll() {
        self.task?.cancel()
        self.status = .loading
        self.showLoading(true)
        self.task = self.interactor
            .list()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.showLoading(false)
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    self?.status = .error(message: error.errorMessage)
                }
            } receiveValue: { [weak self] cars in
                self?.status = cars.isEmpty ? .empty : .data(items: cars)
            }
    }
    
    func filter() {
        self.status = .data(items: [])
    }
}

extension CarsListViewModel {
    private func showLoading(_ isShow: Bool) {
        LoadingViewManager.shared.show = isShow
    }
}
