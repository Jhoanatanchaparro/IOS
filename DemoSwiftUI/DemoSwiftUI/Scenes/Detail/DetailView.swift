//
//  Detail.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 2/07/25.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        
        VStack {
            Button {
                NavigatorViewManager.shared.popTo(LoginView.self)
            } label: {
                Text("Ir al Login")
            }
        }
    }
}

extension DetailView {
    static func build() -> NavigatorScreen {
        let view = DetailView()
        return NavigatorScreen(view: view)
    }
}

#Preview {
    DetailView()
}
