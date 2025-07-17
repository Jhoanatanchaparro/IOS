//
//  DemoSwiftUIApp.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 28/05/25.
//

import SwiftUI

@main
struct DemoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigatorView(root: LoginView.build())
                LoadingView()
            }
        }
    }
}
