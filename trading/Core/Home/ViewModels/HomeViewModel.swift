//
//  HomeViewModel.swift
//  trading
//
//  Created by Mayank Dev on 09/07/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfoliozCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
       addSubscribers()
    }
    
    func addSubscribers(){
        
        dataService.$allCoins
            .sink {[weak self](returnedCoins) in
                self?.allCoins = returnedCoins
        }
            .store(in: &cancellables)
    }

}
