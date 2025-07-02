//
//  BaseTextField.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 28/05/25.
//

import SwiftUI

struct BaseTextField: View {
    @Binding var text: String
    private let height: CGFloat = 50
    private let cornerRadius: CGFloat = 8
    private var placeholder: String = ""
    private var borderColor: Color = .black
    private var borderWidth: CGFloat = 1
    private var backgroundColor: Color = .white
    private var textColor: Color = .black
    private var keyboardType: UIKeyboardType = .default
    private var rightView: AnyView?
    private var leftView: AnyView?
    private var secureTextEnabled: Bool = false
    private var onEditingChanged: (() -> Void)?
    private var onEditingBegan: (() -> Void)?
    private var onDidEditing: (() -> Void)?
    
    var body: some View {
        
        VStack {
            HStack {
                TextLabel(text: self.placeholder, color: .neutral500)
                Spacer()
            }
            HStack {
                
                if let leftView = self.leftView {
                    leftView
                }
                
                CoreTextField(text: $text)
                    .keyboardType(self.keyboardType)
                    .textColor(self.textColor)
                    .secureTextEnabled(self.secureTextEnabled)
                    .onEditingChanged(self.onEditingChanged)
                    .onEditingBegan(self.onEditingBegan)
                    .onDidEditing(self.onDidEditing)
                
                if let rightView = self.rightView {
                    rightView
                }
            }
            .padding(.horizontal, Spacing._sm)
            .frame(height: self.height)
            .background(self.backgroundColor)
            .cornerRadius(self.cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(self.borderColor, lineWidth: self.borderWidth)
            }
        }
    }
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func placeholder(_ value: String) -> Self {
        var view = self
        view.placeholder = value
        return view
    }
    
    func borderColor(_ value: Color) -> Self {
        var view = self
        view.borderColor = value
        return view
    }
    
    func borderWidth(_ value: CGFloat) -> Self {
        var view = self
        view.borderWidth = value
        return view
    }
    
    func backgroundColor(_ value: Color) -> Self {
        var view = self
        view.backgroundColor = value
        return view
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

#Preview {
    BaseTextField(text: .constant(""))
        .leftView(AnyView(
            SecondaryButton(title: "")
                .rightIcon(Image(systemName: "chevron.left"))
                .onClick({
                    
                })
        ))
        .placeholder("Place holder")
        .padding()
}
