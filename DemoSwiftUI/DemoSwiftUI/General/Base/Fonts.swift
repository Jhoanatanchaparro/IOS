//
//  Fonts.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 17/06/25.
//

import SwiftUI

struct Fonts {
    static var display: Font { Weight.bold(Size._4xl) }
    static var title_lg: Font { Weight.bold(Size._3xl) }
    static var title_md: Font { Weight.bold(Size._2xl) }
    static var title_sm: Font { Weight.bold(Size._xl) }
    static var subTitle: Font { Weight.bold(Size._xl) }
    static var body_regular: Font { Weight.regular(Size._md) }
    static var body_bold: Font { Weight.bold(Size._md) }
    static var label_md: Font { Weight.bold(Size._md) }
    static var label_sm: Font { Weight.bold(Size._sm) }
    static var button: Font { Weight.bold(Size._lg) }
    static var link: Font { Weight.bold(Size._lg) }
    static var caption: Font { Weight.regular(Size._xs) }
    static var caption_bold: Font { Weight.bold(Size._xs) }
}

extension Fonts {
    
    private struct Weight {
        static func regular(_ size: CGFloat) -> Font {
            .custom("Lato-Regular", size: size)
        }
        static func bold(_ size: CGFloat) -> Font {
            .custom("Lato-Bold", size: size)
        }
    }
    
    private struct Size {
        static var _xs: CGFloat { 12 }
        static var _sm: CGFloat { 14 }
        static var _md: CGFloat { 16 }
        static var _lg: CGFloat { 18 }
        static var _xl: CGFloat { 24 }
        static var _2xl: CGFloat { 32 }
        static var _3xl: CGFloat { 40 }
        static var _4xl: CGFloat { 48 }
        static var _5xl: CGFloat { 56 }
    }
}
