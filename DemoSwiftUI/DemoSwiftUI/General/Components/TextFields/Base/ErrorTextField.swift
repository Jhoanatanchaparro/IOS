//
//  ErrorTextField.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 11/06/25.
//

import SwiftUI

struct ErrorTextField: View {
    
    @Binding var text: String
    private var validations: [Validation]
    
    @State private var status: Status = .normal
    @State private var errorMessage: String = ""
    
    private var placeholder: String = ""
    private var keyboardType: UIKeyboardType = .default
    private var rightView: AnyView?
    private var leftView: AnyView?
    private var secureTextEnabled: Bool = false
    private var onEditingChanged: (() -> Void)?
    private var onInputValid: ((Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            BaseTextField(text: $text)
                .placeholder(self.placeholder)
                .borderColor(self.status.style.borderColor)
                .borderWidth(self.status.style.borderWidth)
                .backgroundColor(.white)
                .textColor(.black)
                .keyboardType(self.keyboardType)
                .rightView(self.rightView)
                .leftView(self.leftView)
                .secureTextEnabled(self.secureTextEnabled)
                .onEditingChanged {
                    withAnimation(.snappy, { self.editingChanged() })
                }
                .onEditingBegan {
                    withAnimation(.snappy, { self.editingBegan() })
                }
                .onDidEditing {
                    withAnimation(.snappy, { self.didEditing() })
                }
            
            if self.status == .error {
                HStack {
                    TextCaption(text: self.errorMessage, color: .error500)
                    Spacer()
                }
            }
        }
    }
    
    private func getFailValidation() -> Validation? {
        self.validations.first { validation in
            !validation.validateText(self.text)
        }
    }
    
    private func editingBegan() {
        let failValidation = self.getFailValidation()
        self.onInputValid?(failValidation == nil)
        self.status = failValidation == nil ? .editing : .error
        self.errorMessage = failValidation?.errorMessage ?? ""
    }
    
    private func editingChanged() {
        let failValidation = self.getFailValidation()
        self.onInputValid?(failValidation == nil)
        self.status = failValidation == nil ? .editing : .error
        self.errorMessage = failValidation?.errorMessage ?? ""
        self.onEditingChanged?()
    }
    
    private func didEditing() {
        let failValidation = self.getFailValidation()
        self.onInputValid?(failValidation == nil)
        self.errorMessage = failValidation?.errorMessage ?? ""
        
        if self.text.isEmpty {
            self.status = .normal
        } else {
            self.status = failValidation == nil ? .sucess : .error
        }
    }
    
    init(text: Binding<String>, validations: [Validation]) {
        _text = text
        self.validations = validations
    }
    
    func placeholder(_ value: String) -> Self {
        var view = self
        view.placeholder = value
        return view
    }
    
    func keyboardType(_ value: UIKeyboardType) -> Self {
        var view = self
        view.keyboardType = value
        return view
    }
    
    func rightView(_ value: AnyView?) -> Self {
        var view = self
        view.rightView = value
        return view
    }
    
    func leftView(_ value: AnyView?) -> Self {
        var view = self
        view.leftView = value
        return view
    }
    
    func secureTextEnabled(_ value: Bool) -> Self {
        var view = self
        view.secureTextEnabled = value
        return view
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

extension ErrorTextField {
    fileprivate enum Status {
        case normal
        case error
        case editing
        case sucess
        
        var style: (borderColor: Color, borderWidth: CGFloat) {
            switch self {
            case .normal:
                (Color.primary500, 1.5)
            case .error:
                (Color.error300, 2)
            case .editing:
                (Color.primary500, 2)
            case .sucess:
                (Color.success500, 1.5)
            }
        }
    }
}

extension ErrorTextField {
    struct Validation {
        private var regex: String
        fileprivate var errorMessage: String
    
        init(regex: String, errorMessage: String) {
            self.regex = regex
            self.errorMessage = errorMessage
        }
        
        fileprivate func validateText(_ text: String) -> Bool {
            NSPredicate(format: "SELF MATCHES %@", self.regex).evaluate(with: text)
        }
    }
}

struct DemoText: View {
    
    @State var text1: String = ""
    @State var text2: String = ""
    
    var body: some View {
        ErrorTextField(text: $text1,
                       validations: [])
            .padding()
        
        ErrorTextField(text: $text2,
                       validations: [])
            .padding()
  
    }
}

#Preview {
    DemoText()
}

