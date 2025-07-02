//
//  NavigatorView.swift
//  DemoSwiftUI
//
//  Created by Kenyi Rodriguez on 2/07/25.
//

import SwiftUI

struct NavigatorView: View {
    
    @StateObject private var manager = NavigatorViewManager.shared
    private var root: NavigatorScreen
    
    init(root: NavigatorScreen) {
        self.root = root
    }
    
    var body: some View {
        NavigationStack(path: self.$manager.path) {
            self.root
                .view
                .navigationDestination(for: NavigatorScreen.self) { screen in
                    screen.view
                }
        }
    }
}

final class NavigatorViewManager: ObservableObject {
    
    static let shared = NavigatorViewManager()
    
    @Published fileprivate var path = [NavigatorScreen]()
    
    private init() { }
    
    func push(_ screen: NavigatorScreen) {
        self.path.append(screen)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func insert(_ view: NavigatorScreen, at index: Int) {
        self.path.insert(view, at: index)
    }
    
    func popTo<Pepito: View>(_ type: Pepito.Type) {
        guard let index = self.path.lastIndex(where: { $0.typeName == String(describing: Pepito.self) }) else {
            return
        }
        
        self.path.removeSubrange((index + 1)..<self.path.count)
    }
}
/*
 
 0 - login
 1 - home
 2 - detalle
 3 - edicion
 */
