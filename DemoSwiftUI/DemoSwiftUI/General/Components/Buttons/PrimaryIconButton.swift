//
//  PrimaryIconButton.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 13/06/25.
//

import SwiftUI

struct PrimaryIconButton: View {
    
    private var onClick: (() -> Void)?
    private var icon: Image?
    
    var body: some View {
        BaseButton(title: "")
            .foregroundColor(.white)
            .backgroundColor(.blue)
            .rightIcon(self.icon)
            .onClick(self.onClick)
    }
    
    init(icon: Image) {
        self.icon = icon
    }
    
    func onClick(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onClick = value
        return view
    }
}

#Preview {
    PrimaryIconButton(icon: Image(systemName: "chevron.right"))
}
