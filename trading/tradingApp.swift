//
//  tradingApp.swift
//  trading
//
//  Created by Mayank Dev on 08/07/25.
//

import SwiftUI

@main
struct tradingApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
