//
//  All_in_the_DetailsApp.swift
//  All in the Details
//
//  Created by Alex Stanage on 3/5/26.
//

import SwiftUI

@main
struct All_in_the_DetailsApp: App {
    @State private var viewModel = PortfolioViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
