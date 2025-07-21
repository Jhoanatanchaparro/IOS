//
//  MainTabView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .movies
    
    var body: some View {
        TabView(selection: $selectedTab){
            ForEach(TabItem.allCases, id: \.self){ tab in
                tab.view
                    .tabItem{
                        Image(systemName: tab.icon)
                        Text(tab.title)
                    }
                    .tag(tab)
            }
        }
    }
}
