//
//  MLoginView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 1/07/25.
//

import SwiftUI

struct MLoginView: View {
    
    @ObservedObject var model = MLoginView.Model()
    var events = MLoginView.Events()

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
}

extension MLoginView {
    struct Events {
        var onForgotPassword: (() -> Void)?
        var onLogin: (() -> Void)?
    }
    
    class Model: ObservableObject {
        @Published var user: String = ""
        @Published var password: String = ""
        @Published var saveSession: Bool = true
        @Published var userIsValid: Bool = false
        @Published var passwordIsValid: Bool = false
        @Published var canDoLogin: Bool = false
    }
}

extension MLoginView {
    private var userTextField: some View {
        EmailTextField(text: self.$model.user)
            .onInputValid { isValid in
                self.model.userIsValid = isValid
            }
    }
    
    private var passwordTextField: some View {
        PasswordTextField(text: self.$model.password)
            .onInputValid { isValid in
                self.model.passwordIsValid = isValid
            }
    }
    
    private var loginButton: some View {
        PrimaryButton(title: "Iniciar sesión")
            .state(self.model.canDoLogin ? .enable : .disable)
            .onClick {
                self.events.onLogin?()
            }
    }
    
    private var saveSessionOption: some View {
        CheckBox(checked: self.$model.saveSession, text: "Recordar correo")
    }
    
    private var recoverPasswordButton: some View {
        HStack {
            LinkButton(title: "¿Olvidaste tu constraseña?")
                .onClick {
                    self.events.onForgotPassword?()
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

#Preview {
    MLoginView()
}
