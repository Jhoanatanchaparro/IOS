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
    
    private let interactor: UserInteractorProtocol
    private let errorHandler: ViewErrorHandler
    private var task: AnyCancellable?
    
    init(interactor: UserInteractorProtocol, errorHandler: ViewErrorHandler) {
        self.interactor = interactor
        self.errorHandler = errorHandler
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
        self.showLoading(true)
        self.task = self.interactor
            .signIn(self.user, password: self.password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.showLoading(false)
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    self?.errorHandler.execute(error)
                }
            } receiveValue: {
                self.goToDetail()
            }
    }
    
    private func goToDetail() {
        NavigatorViewManager
            .shared
            .push(DetailView.build())
    }
    
    private func showLoading(_ isShow: Bool) {
        LoadingViewManager.shared.show = isShow
    }
}
