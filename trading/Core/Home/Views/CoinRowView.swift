//
//  CoinRowView.swift
//  trading
//
//  Created by Mayank Dev on 09/07/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn : Bool
    
    var body: some View {
        HStack(spacing: 0) {
           leftColumn
          Spacer()
            if(showHoldingColumn){
               centralColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(
        coin: DeveloperPreview.instance.coin,
        showHoldingColumn: false
    )
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(width: 30)

            AsyncImage(url: URL(string: coin.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 30, height: 30)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
//            CoinImageView(coin: coin)
//                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 0) {
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundColor(Color.theme.accent)
            }
        }
    }
    
    private var centralColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
        
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text((coin.priceChangePercentage24H?.asPercentString() ?? "0.00%"))
                
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing )

    }
    
}
