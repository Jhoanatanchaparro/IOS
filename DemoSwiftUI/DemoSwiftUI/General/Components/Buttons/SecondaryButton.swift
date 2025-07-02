//
//  SecondaryButton.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 6/06/25.
//

import SwiftUI

struct SecondaryButton: View {
    
    private var title: String = ""
    private var onClick: (() -> Void)?
    private var leftIcon: Image?
    private var rightIcon: Image?
    
    var body: some View {
        BaseButton(title: self.title)
            .foregroundColor(.blue)
            .backgroundColor(.white)
            .borderColor(.blue)
            .borderWidth(1)
            .leftIcon(self.leftIcon)
            .rightIcon(self.rightIcon)
            .onClick(self.onClick)
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
}

#Preview {
    SecondaryButton(title: "Texto")
        .rightIcon(Image(systemName: "chevron.right"))
        .leftIcon(Image(systemName: "chevron.left"))
        .onClick {
            print("me tocaron")
        }
}
