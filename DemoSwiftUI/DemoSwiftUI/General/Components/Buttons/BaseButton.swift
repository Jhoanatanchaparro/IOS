//
//  BaseButton.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 6/06/25.
//

import SwiftUI

struct BaseButton: View {
    
    private var height: CGFloat { 50 }
    private var title: String = ""
    private var onClick: (() -> Void)?
    private var leftIcon: Image?
    private var rightIcon: Image?
    private var backgroundColor: Color = .white
    private var foregroundColor: Color = .white
    private var borderWidth: CGFloat = 0
    private var borderColor: Color = .clear
    private var size: Size = .full
    
    var body: some View {
        Button(action: {
            self.onClick?()
        }, label: {
            HStack(spacing: 10) {
                
                if self.size == .full {
                    Spacer()
                }
                
                if let leftIcon = self.leftIcon {
                    leftIcon.foregroundStyle(self.foregroundColor)
                }

                if !self.title.isEmpty {
                    TextBody(text: self.title, color: self.foregroundColor, type: .bold)
                }
                
                if let rightIcon = self.rightIcon {
                    rightIcon.foregroundStyle(self.foregroundColor)
                }
                
                if self.size == .full {
                    Spacer()
                }
            }
        })
        .frame(height: self.height)
        .padding(.horizontal, Spacing._lg)
        .background(self.backgroundColor)
        .cornerRadius(self.height / 2)
        .overlay {
            RoundedRectangle(cornerRadius: self.height / 2)
                .stroke(self.borderColor, lineWidth: self.borderWidth)
        }
    }
    
    init(title: String) {
        self.title = title
    }
    
    func leftIcon(_ value: Image?) -> Self {
        var view = self
        view.leftIcon = value
        return view
    }
    
    func rightIcon(_ value: Image?) -> Self {
        var view = self
        view.rightIcon = value
        return view
    }
    
    func onClick(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onClick = value
        return view
    }
    
    func backgroundColor(_ value: Color) -> Self {
        var view = self
        view.backgroundColor = value
        return view
    }
    
    func foregroundColor(_ value: Color) -> Self {
        var view = self
        view.foregroundColor = value
        return view
    }
    
    func borderWidth(_ value: CGFloat) -> Self {
        var view = self
        view.borderWidth = value
        return view
    }
    
    func borderColor(_ value: Color) -> Self {
        var view = self
        view.borderColor = value
        return view
    }
    
    func size(_ value: Size) -> Self {
        var view = self
        view.size = value
        return view
    }
}

extension BaseButton {
    enum Size {
        case fit
        case full
    }
}

#Preview {
    BaseButton(title: "texto de prueba")
        .backgroundColor(.blue)
        .foregroundColor(.white)
        .rightIcon(Image(systemName: "chevron.right"))
}
