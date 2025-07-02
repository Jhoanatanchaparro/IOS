//
//  LoginViewModel.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 20/06/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var user: String = ""
    @Published var password: String = ""
    @Published var saveSession: Bool = true
    @Published var userIsValid: Bool = false
    @Published var passwordIsValid: Bool = false
    
    @Published private(set) var canDoLogin: Bool = false
    
    private let service: LoginServiceProtocol
    private var task: AnyCancellable?
    
    init(service: LoginServiceProtocol) {
        self.service = service
        self.validateForm()
    }
    
    deinit { self.task?.cancel() }
}

extension LoginViewModel {
    func onClickLoginButton() {
        self.doLogin()
    }
}

extension LoginViewModel {
    private func validateForm() {
        Publishers
            .CombineLatest($userIsValid, $passwordIsValid)
            .map { validModel in
                validModel.0 && validModel.1
            }
            .removeDuplicates()
            .assign(to: &$canDoLogin)
    }
    
    private func doLogin() {
        self.task?.cancel()
        self.task = self
            .service.executeWith(self.user, password: self.password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    print(error.errorMessage)
                }
                
            } receiveValue: { token in
                print("LOGIN SUCCESS: \(token)")
                self.goToDetail()
            }
    }
    
    private func goToDetail() {
        NavigatorViewManager
            .shared
            .push(DetailView.build())
    }
}
