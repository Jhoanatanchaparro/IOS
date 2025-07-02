//
//  EmailTextField.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 11/06/25.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var text: String
    private var onEditingChanged: (() -> Void)?
    private var onInputValid: ((Bool) -> Void)?
    
    private var validations: [ErrorTextField.Validation] {
        [ErrorTextField.Validation(regex: "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$", errorMessage: "Correo Invalido")] 
    }
    
    var body: some View {
        ErrorTextField(text: $text, validations: self.validations)
            .placeholder("Correo")
            .keyboardType(.emailAddress)
            .secureTextEnabled(false)
            .onEditingChanged(self.onEditingChanged)
            .onInputValid(self.onInputValid)
        
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
}
