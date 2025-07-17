//
//  CloseSessionService.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

import Foundation
import Combine

protocol SignOutServiceProtocol {
    func execute() -> AnyPublisher<Void, ServiceErrorDTO>
}

struct SignOutService: SignOutServiceProtocol {
    func execute() -> AnyPublisher<Void, ServiceErrorDTO> {
        Future { promise in
            promise(.success(()))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

struct SignOutServiceMock: SignOutServiceProtocol {
    func execute() -> AnyPublisher<Void, ServiceErrorDTO> {
        Future { promise in
            promise(.success(()))
        }
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
