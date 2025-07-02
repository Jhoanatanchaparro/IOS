//
//  LinkButton.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/06/25.
//

import SwiftUI

struct LinkButton: View {
    
    private var onClick: (() -> Void)?
    private var title: String
    private let color: Color = .neutral500
    
    var body: some View {
        Button(action: { self.onClick?() }) {
            Text(self.title)
                .font(Fonts.label_md)
                .foregroundStyle(self.color)
                .foregroundStyle(.gray)
                .underline(true)
        }
    }
    
    init(title: String) {
        self.title = title
    }
    
    func onClick(_ value: (() -> Void)?) -> Self {
        var view = self
        view.onClick = value
        return view
    }
}
