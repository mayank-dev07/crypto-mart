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
        HStack {
            ForEach(filteredStats) { stat in
                StatsticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
    }
    
    private var filteredStats: [StatisticModel] {
        if showPortfolio {
            return vm.StatData.filter { stat in
                stat.title == "24h Volume" ||
                stat.title == "Btc Dominance" ||
                stat.title == "Portfolio Value"
            }
        } else {
            return vm.StatData.filter { stat in
                stat.title == "Market Cap" ||
                stat.title == "24h Volume" ||
                stat.title == "Btc Dominance"
            }
        }
    }
}


#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
