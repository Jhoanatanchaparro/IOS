//
//  TextBody.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/06/25.
//

import SwiftUI

struct TextBody: View {
    var text: String
    var color: Color = .neutral500
    var type: Style = .regular
    var body: some View {
        Text(self.text)
            .font(self.type.font)
            .foregroundStyle(self.color)
            .lineLimit(nil)
            .lineSpacing(5)
    }
    
    enum Style {
        case regular
        case bold
        var font: Font {
            switch self {
            case .regular:
                Fonts.body_regular
            case .bold:
                Fonts.body_bold
            }
        }
    }
}
