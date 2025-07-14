//
//  StatsticView.swift
//  trading
//
//  Created by Mayank Dev on 13/07/25.
//

import SwiftUI

struct StatsticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
            HStack (spacing: 5) {
                Image(systemName: "triangle.fill")
                    
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "").font(.headline)
            }
            .foregroundColor((stat.percentageChange ?? 0) > 0 ? Color.theme.green : Color.theme.red)
            .opacity(((stat.percentageChange != nil) ? 1 : 0))
        }
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout){
    StatsticView(stat: DeveloperPreview.instance.stat3)
}
