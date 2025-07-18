//
//  CarInteractor.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

import Combine

protocol CarInteractorProtocol {
    func list() -> AnyPublisher<[Car], ServiceError>
}

struct CarInteractor: CarInteractorProtocol {
    
    private let carsService: CarsServiceProtocol
    
    init(carsService: CarsServiceProtocol) {
        self.carsService = carsService
    }
    
    func list() -> AnyPublisher<[Car], ServiceError> {
        self.carsService
            .execute()
            .map({ arrayCarDTO in
                arrayCarDTO.map({ carDTO in
                    Car(dto: carDTO)
                })
            })
            .mapServiceError()
            .eraseToAnyPublisher()
    }
}
