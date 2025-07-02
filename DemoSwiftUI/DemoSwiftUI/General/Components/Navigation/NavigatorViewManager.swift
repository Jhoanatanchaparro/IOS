//
//  NavigatorViewManager.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 2/07/25.
//

import SwiftUI


struct NavigatorScreen: Identifiable, Hashable {
    
    let view: AnyView
    let id = UUID()
    let typeName: String
    
    init<Pepito: View>(view: Pepito) {
        self.view = AnyView(view)
        self.typeName = String(describing: Pepito.self)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    
    func hash(into h: inout Hasher) { h.combine(self.id) }
}
