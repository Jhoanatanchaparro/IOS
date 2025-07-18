//
//  CarsService.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 15/07/25.
//

import Foundation
import Combine
import Alamofire

protocol CarsServiceProtocol {
    func execute() -> AnyPublisher<[CarDTO], ServiceErrorDTO>
}

struct CarsService: CarsServiceProtocol {
    
    private var url: String { "https://mocki.io/v1/85d87f90-cc48-44cc-95fa-08f9f33857cb" }
    
    func execute() -> AnyPublisher<[CarDTO], ServiceErrorDTO> {
        AF.request(self.url,
                   method: .get,
                   encoding: JSONEncoding.default)
        .publishData()
        .tryMap { responseData in
            try ServiceParse.decode(responseData)
        }
        .mapServiceErrorDTO()
        .eraseToAnyPublisher()
    }
}

struct CarsServiceMock: CarsServiceProtocol {
    func execute() -> AnyPublisher<[CarDTO], ServiceErrorDTO> {
        Future { promise in
            promise(.success([.mock, .mock, .mock, .mock, .mock]))
        }
        .delay(for: .seconds(0), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct CarsServiceMockFailure: CarsServiceProtocol {
    func execute() -> AnyPublisher<[CarDTO], ServiceErrorDTO> {
        Future { promise in
            promise(.failure(.init(statusCode: 401)))
        }
        .delay(for: .seconds(0), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
