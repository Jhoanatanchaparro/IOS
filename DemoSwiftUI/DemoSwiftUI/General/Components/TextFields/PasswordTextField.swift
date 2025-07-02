//
//  PasswordTextField.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 13/06/25.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var text: String
    private var onEditingChanged: (() -> Void)?
    private var onInputValid: ((Bool) -> Void)?
    @State private var securePassword: Bool = true
    
    private var validations: [ErrorTextField.Validation] {
        [
            ErrorTextField.Validation(regex: ".*[A-Z].*",
                                      errorMessage: "No cuenta con al menos una mayúscula."),
            
            ErrorTextField.Validation(regex: ".*[0-9].*",
                                      errorMessage: "No cuenta con al menos un número."),
            
            ErrorTextField.Validation(regex: "^.{6,}$",
                                      errorMessage: "Debe tener mínimo 6 caracteres.")
         
        ]
    }
    
    var body: some View {
        ErrorTextField(text: $text, validations: self.validations)
            .placeholder("Ingresa tu contraseña")
            .keyboardType(.default)
            .secureTextEnabled(self.securePassword)
            .onEditingChanged(self.onEditingChanged)
            .onInputValid(self.onInputValid)
            .rightView(AnyView(self.iconButton))
        
    }
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func onEditingChanged(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onEditingChanged = value
        return view
    }
    
    func onInputValid(_ value: ((Bool) -> Void)?) -> Self {
        var view = self
        view.onInputValid = value
        return view
    }
    
    private var iconButton: some View {
        Image(systemName: self.securePassword ? "eye.slash" : "eye")
            .padding(10)
            .onTapGesture {
                self.securePassword.toggle()
            }
    }
}
