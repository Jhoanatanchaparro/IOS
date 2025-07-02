//
//  CoreTextField.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 11/06/25.
//

import SwiftUI

struct CoreTextField: View {
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    private var textColor: Color = Color.neutral500
    private var keyboardType: UIKeyboardType = .default
    private var secureTextEnabled: Bool = false
    private var onEditingChanged: (() -> Void)?
    private var onEditingBegan: (() -> Void)?
    private var onDidEditing: (() -> Void)?
    private var font = Fonts.body_regular
    
    var body: some View {
        Group {
            if self.secureTextEnabled {
                SecureField("Escriba aquí...", text: $text)
                    .font(self.font)
                    .foregroundStyle(self.textColor)
                    .keyboardType(self.keyboardType)
                
            } else {
                TextField("Escriba aquí...", text: $text)
                    .font(self.font)
                    .foregroundStyle(self.textColor)
                    .keyboardType(self.keyboardType)
            }
        }
        .focused($isFocused)
        .onChange(of: self.text) { _, _ in
            self.onEditingChanged?()
        }
        .onChange(of: self.isFocused) { _, newValue in
            newValue ? self.onEditingBegan?() : self.onDidEditing?()
        }
    }
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func textColor(_ value: Color) -> Self {
        var view = self
        view.textColor = value
        return view
    }
    
    func keyboardType(_ value: UIKeyboardType) -> Self {
        var view = self
        view.keyboardType = value
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
    
    func onEditingBegan(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onEditingBegan = value
        return view
    }
    
    func onDidEditing(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onDidEditing = value
        return view
    }
}
