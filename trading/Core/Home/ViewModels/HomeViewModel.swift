//
//  HomeViewModel.swift
//  trading
//
//  Created by Mayank Dev on 09/07/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var StatData: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                let lowercasedText = text.lowercased()
                
                return startingCoins.filter { coin in
                    coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returnedCoins in
                print("🔍 Filtered Coins: \(returnedCoins.count)")
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map { marketDataModel -> [StatisticModel] in
                var statData: [StatisticModel] = []
                guard let data = marketDataModel else {
                    print("⚠️ Market data is nil")
                    return statData
                }

                let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = StatisticModel(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticModel(title: "Btc Dominance", value: data.btcDominance)
                let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

                statData.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolio
                ])
                
                return statData
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedStats in
                print("📊 Received Stats: \(returnedStats.map(\.title))")
                self?.StatData = returnedStats
            }
            .store(in: &cancellables)
    }
}
