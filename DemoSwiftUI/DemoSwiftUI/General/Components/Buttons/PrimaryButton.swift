//
//  PrimaryButton.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 4/06/25.
//

import SwiftUI

struct PrimaryButton: View {
    
    private var state: State = .enable
    private var title: String = ""
    private var onClick: (() -> Void)?
    private var leftIcon: Image?
    private var rightIcon: Image?
    private var size: BaseButton.Size = .full
    
    var body: some View {
        BaseButton(title: self.title)
            .foregroundColor(self.state.style.foregroundColor)
            .backgroundColor(self.state.style.backgroundColor)
            .leftIcon(self.leftIcon)
            .rightIcon(self.rightIcon)
            .onClick(self.state == .enable ? self.onClick : nil)
            .size(self.size)
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
    
    func state(_ value: State) -> Self {
        var view = self
        view.state = value
        return view
    }
    
    func onClick(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onClick = value
        return view
    }
    
    func size(_ value: BaseButton.Size) -> Self {
        var view = self
        view.size = value
        return view
    }
}

extension PrimaryButton {
    enum State {
        case enable
        case disable
        
        var style: (backgroundColor: Color, foregroundColor: Color) {
            switch self {
            case .enable:
                (Color.neutral700, Color.white)
            case .disable:
                (Color.neutral200, Color.white)
            }
        }
    }
}

#Preview {
    PrimaryButton(title: "Texto")
        .rightIcon(Image(systemName: "chevron.right"))
        .leftIcon(Image(systemName: "chevron.left"))
        .onClick {
            print("me tocaron")
        }
        .state(.enable)
    
    PrimaryButton(title: "Texto")
        .rightIcon(Image(systemName: "chevron.right"))
        .leftIcon(Image(systemName: "chevron.left"))
        .onClick {
            print("me tocaron")
        }
        .state(.disable)
        .size(.fit)
}
