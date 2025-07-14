//
//  HomeStatView.swift
//  trading
//
//  Created by Mayank Dev on 13/07/25.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
            HStack{
                ForEach(vm.StatData) { stat in
                    StatsticView(stat: stat)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
            }
        }
}


#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
