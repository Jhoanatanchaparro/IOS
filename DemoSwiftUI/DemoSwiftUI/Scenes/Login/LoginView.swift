//
//  LoginView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/06/25.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel

    var body: some View {
        self.contentView {
            self.formView {
                self.userTextField
                self.passwordTextField
                self.saveSessionOption
                self.recoverPasswordButton
                self.loginButton
            }
        }
    }
    
    fileprivate init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}

extension LoginView {
    private var userTextField: some View {
        EmailTextField(text: self.$viewModel.user)
            .onInputValid { isValid in
                self.viewModel.userIsValid = isValid
            }
    }
    
    private var passwordTextField: some View {
        PasswordTextField(text: self.$viewModel.password)
            .onInputValid { isValid in
                self.viewModel.passwordIsValid = isValid
            }
    }
    
    private var loginButton: some View {
        PrimaryButton(title: "Iniciar sesión")
            .state(self.viewModel.canDoLogin ? .enable : .disable)
            .onClick {
                self.viewModel.onClickLoginButton()
            }
    }
    
    private var saveSessionOption: some View {
        CheckBox(checked: self.$viewModel.saveSession, text: "Recordar correo")
    }
    
    private var recoverPasswordButton: some View {
        HStack {
            LinkButton(title: "¿Olvidaste tu constraseña?")
                .onClick {
                    
                }
            Spacer()
        }
    }
    
    private func contentView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack {
            Spacer()
            view()
            Spacer()
        }
        .padding(Spacing._md)
        .background(Color.gray.opacity(0.2))
    }
    
    private func formView(@ViewBuilder view: @escaping () -> some View) -> some View {
        VStack(spacing: Spacing._lg) { view() }
            .padding(Spacing._lg)
            .background(.white)
            .cornerRadius(10)
    }
}

extension LoginView {
    
    static func build() -> NavigatorScreen {
        let service = LoginService()
        let viewModel = LoginViewModel(service: service)
        let view = LoginView(viewModel: viewModel)
        let screen = NavigatorScreen(view: view)
        return screen
    }
    
    static func buildPresent() -> some View {
        let service = LoginService()
        let viewModel = LoginViewModel(service: service)
        let view = LoginView(viewModel: viewModel)
        return view
    }
    
    static func buildSuccessMock() -> some View {
        let service = LoginServiceMock()
        let viewModel = LoginViewModel(service: service)
        let view = LoginView(viewModel: viewModel)
        return view
    }
    
    static func buildErrorMock() -> some View {
        let service = LoginServiceErrorMock()
        let viewModel = LoginViewModel(service: service)
        let view = LoginView(viewModel: viewModel)
        return view
    }
}

#Preview {
    LoginView.buildSuccessMock()
}
