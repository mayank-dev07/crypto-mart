//
//  CoinImageService.swift
//  trading
//
//  Created by Mayank Dev on 11/07/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    
    init(url: String){
        getCoinImage(url: url)
    }
    
    private func getCoinImage(url: String){
        guard let url = URL(string: url)
            else {
                return
            }
        
        imageSubscription = NetworkingManager.download(url: url)
                .tryMap({ (data) -> UIImage? in
                    return UIImage(data: data)
                })
                .sink(receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedImage) in
                    self?.image = returnedImage
                    self?.imageSubscription?.cancel()
                })
    }
}
