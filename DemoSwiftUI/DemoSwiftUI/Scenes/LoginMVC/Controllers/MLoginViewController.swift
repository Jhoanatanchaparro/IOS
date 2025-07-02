//
//  MLoginViewController.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 1/07/25.
//

import SwiftUI
import Combine

class MLoginViewController: UIHostingController<MLoginView> {

    private let service: LoginServiceProtocol
    private var task: AnyCancellable?
    
    init(view: MLoginView, service: LoginServiceProtocol) {
        self.service = service
        super.init(rootView: view)
        self.setHandlers()
    }
    
    deinit { self.task?.cancel() }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLoginViewController {
    
    private func setHandlers() {
        self.rootView.events.onLogin = { self.doLogin() }
        self.rootView.events.onForgotPassword = { print("GO TO FORGOT PASSWORD") }
    }
    
    private func validateForm() {
        Publishers
            .CombineLatest(self.rootView.model.$userIsValid, self.rootView.model.$passwordIsValid)
            .map { validModel in
                validModel.0 && validModel.1
            }
            .removeDuplicates()
            .assign(to: &self.rootView.model.$canDoLogin)
    }
    
    private func doLogin() {
        self.task?.cancel()
        self.task = self.service
            .executeWith(self.rootView.model.user, password: self.rootView.model.password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                defer { self?.task = nil }
                if case .failure(let error) = completion {
                    print(error.errorMessage)
                }
                
            } receiveValue: { token in
                print("GO TO LOGIN SUCCESS: \(token)")
            }
    }
    
    func dd() {
        var array = [String]()
        array.append("1") //Login
        array.append("2") //Home
        array.append("3") //Detalle
        array.append("4") //Editar

    }
}

extension MLoginViewController {
    static func build() -> MLoginViewController {
        let service = LoginService()
        let view = MLoginView()
        let controller = MLoginViewController(view: view, service: service)
        return controller
    }
    
    static func buildSuccessMock() -> MLoginViewController {
        let service = LoginServiceMock()
        let view = MLoginView()
        let controller = MLoginViewController(view: view, service: service)
        return controller
    }
    
    static func buildErrorMock() -> MLoginViewController {
        let service = LoginServiceErrorMock()
        let view = MLoginView()
        let controller = MLoginViewController(view: view, service: service)
        return controller
    }
}
