//
//  ServiceError.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

import Combine

struct ServiceError: Error {
    
    let reason: Reason
    
    var errorMessage: String {
        self.messages[self.reason] ?? "Ocurrio un error en la petición"
    }
    
    private let messages: [Reason: String] = [
        .badRequest: "Ocurrio un error en la petición",
        .unauthorized: "La sesión no esta autorizada para esta operación",
        .forbidden: "Ocurrio un error en la petición",
        .notFound: "Ocurrio un error en la petición",
        .internalServiceError: "Ocurrio un error en la petición",
        .generic: "Ocurrio un error en la petición"
    ]
    
    init(dto: ServiceErrorDTO) {
        self.reason = Reason(rawValue: dto.statusCode) ?? .generic
    }
}

extension ServiceError {
    enum Reason: Int {
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case internalServiceError = 500
        case generic = 0
    }
}

extension Publisher where Failure == ServiceErrorDTO {
    func mapServiceError() -> Publishers.MapError<Self, ServiceError> {
        self.mapError { error in
            ServiceError(dto: error)
        }
    }
}
