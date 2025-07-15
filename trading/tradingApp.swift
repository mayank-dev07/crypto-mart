//
//  tradingApp.swift
//  trading
//
//  Created by Mayank Dev on 08/07/25.
//

import SwiftUI

@main
struct tradingApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm) 
        }
    }
}
