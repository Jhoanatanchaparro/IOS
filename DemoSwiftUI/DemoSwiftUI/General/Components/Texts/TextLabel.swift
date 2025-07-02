//
//  TextLabel.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/06/25.
//

import SwiftUI

struct TextLabel: View {
    var text: String
    var color: Color = .neutral500
    var body: some View {
        Text(self.text)
            .font(Fonts.label_md)
            .foregroundStyle(self.color)
            .lineLimit(nil)
            .lineSpacing(3)
    }
}
