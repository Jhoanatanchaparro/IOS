//
//  MLoginFabricController.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 1/07/25.
//

import SwiftUI
import Combine

class MLoginFabricController: UIHostingController<MLoginView> {
    
    private let service: LoginServiceProtocol
    private var task: AnyCancellable?
    
    init(view: MLoginView, service: LoginServiceProtocol) {
        self.service = service
        super.init(rootView: view)
        self.setHandlers()
        self.setInitialData()
    }
    
    deinit { self.task?.cancel() }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLoginFabricController {
    
    private func setInitialData() {
        self.rootView.model.user = "a@a.com"
    }
    
    private func setHandlers() {
        self.rootView.events.onLogin = { self.doLogin() }
    }
    
    private func validateForm() {
        Publishers
            .CombineLatest(self.rootView.model.$userIsValid, self.rootView.model.$passwordIsValid)
            .combineLatest(self.rootView.model.$saveSession)
            .map { validModel, saveSession in
                validModel.0 && validModel.1 && saveSession
            }
            .removeDuplicates()
            .assign(to: &self.rootView.model.$canDoLogin)
    }
    
    private func doLogin() {
        self.task?.cancel()
        self.task = self
            .service.executeWith(self.rootView.model.user, password: self.rootView.model.password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    print(error.errorMessage)
                }
                
            } receiveValue: { token in
                print("GO TO WELCOME SCREEN")
            }
    }
}

extension MLoginFabricController {
    static func build() -> MLoginFabricController {
        let service = LoginService()
        let view = MLoginView()
        let controller = MLoginFabricController(view: view, service: service)
        return controller
    }
    
    static func buildSuccessMock() -> MLoginFabricController {
        let service = LoginServiceMock()
        let view = MLoginView()
        let controller = MLoginFabricController(view: view, service: service)
        return controller
    }
    
    static func buildErrorMock() -> MLoginFabricController {
        let service = LoginServiceErrorMock()
        let view = MLoginView()
        let controller = MLoginFabricController(view: view, service: service)
        return controller
    }
}
