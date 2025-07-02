//
//  LoginService.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 20/06/25.
//

import Foundation
import Combine

protocol LoginServiceProtocol {
    func executeWith(_ user: String, password: String) -> AnyPublisher<String, BaseError>
}

struct LoginService: LoginServiceProtocol {
    func executeWith(_ user: String, password: String) -> AnyPublisher<String, BaseError> {
        Future { promise in
            promise(.success("myToken"))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct LoginServiceMock: LoginServiceProtocol {
    func executeWith(_ user: String, password: String) -> AnyPublisher<String, BaseError> {
        Future { promise in
            promise(.success("myToken"))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct LoginServiceErrorMock: LoginServiceProtocol {
    func executeWith(_ user: String, password: String) -> AnyPublisher<String, BaseError> {
        Future { promise in
            promise(.failure(BaseError(errorMessage: "Ocurrio un problema en la conexión", statusCode: 404)))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
