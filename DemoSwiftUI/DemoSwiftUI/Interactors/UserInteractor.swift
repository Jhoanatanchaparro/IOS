//
//  UserInteractor.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 3/07/25.
//

import Combine

protocol UserInteractorProtocol {
    func signIn(_ user: String, password: String) -> AnyPublisher<Void, ServiceError>
    func signOut() -> AnyPublisher<Void, ServiceError>
}

struct UserInteractor: UserInteractorProtocol {
    private let signInService: SignInServiceProtocol
    private let signOutService: SignOutServiceProtocol
    
    init(signInService: SignInServiceProtocol,
         signOutService: SignOutServiceProtocol) {
        self.signInService = signInService
        self.signOutService = signOutService
    }
    
    func signIn(_ user: String, password: String) -> AnyPublisher<Void, ServiceError> {
        let params = LoginServiceInput(user: user, password: password)
        return self.signInService
            .executeWith(params)
            .map { UserSession.new($0) }
            .mapError { ServiceError(dto: $0) }
            .eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Void, ServiceError> {
        self.signOutService
            .execute()
            .mapError { ServiceError(dto: $0) }
            .eraseToAnyPublisher()
    }
}
