//
//  ContentView.swift
//  All in the Details
//
//  Created by Alex Stanage on 3/5/26.
//

import SwiftUI

/// Main tab-based navigation view for the portfolio app
struct ContentView: View {
    @Environment(PortfolioViewModel.self) private var viewModel
    @State private var selectedTab: Tab = .portfolio
    
    enum Tab: String, CaseIterable {
        case portfolio = "Portfolio"
        case collections = "Collections"
        case about = "About"
        case settings = "Settings"
        
        var icon: String {
            switch self {
            case .portfolio: return "photo.on.rectangle.angled"
            case .collections: return "rectangle.stack.fill"
            case .about: return "person.fill"
            case .settings: return "gearshape.fill"
            }
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabContent(for: tab)
                    .tabItem {
                        Label(tab.rawValue, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .tint(viewModel.accentColor)
        .preferredColorScheme(
            viewModel.isDarkModeOverride.map { $0 ? .dark : .light }
        )
    }
    
    @ViewBuilder
    private func tabContent(for tab: Tab) -> some View {
        switch tab {
        case .portfolio:
            GalleryView()
        case .collections:
            CollectionsView()
        case .about:
            AboutView()
        case .settings:
            SettingsView()
        }
    }
}

#Preview {
    ContentView()
        .environment(PortfolioViewModel())
        .preferredColorScheme(.dark)
}
