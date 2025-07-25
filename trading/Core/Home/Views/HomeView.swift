//
//  HomeView.swift
//  trading
//
//  Created by Mayank Dev on 08/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    var body: some View {

        
        ZStack {
            
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView(isPresented: $showPortfolioView)
                        .environmentObject(vm)
                })

            VStack {
                homeHeader
                if !showPortfolio {
                    HomeStatView(showPortfolio: $showPortfolio)
                    .transition(.move(edge: .leading))
                }
                else {
                    HomeStatView(showPortfolio: $showPortfolio)
                    .transition(.move(edge: .trailing))
                }
                
                SearchBarView(searchText: $vm.searchText)
                HStack {
                    Text("Coin")
                        .padding(.leading, 20)
                    Spacer()
                    if showPortfolio {
                        Text("Holdings")
                    }
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing )
                }
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .padding(.horizontal)
               
                
                if !showPortfolio {
                   allCoinList
                    .transition(.move(edge: .leading))
                }
                else {
                    portfolioCoinList
                    .transition(.move(edge: .trailing))
                }
               
                Spacer(minLength: 0)
            }
        }
    }
}


#Preview("Home View") {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView  {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView = true
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List{
            ForEach(vm.allCoins){
                coin in CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
       
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinList: some View {
        List{
            ForEach(vm.portfolioCoins){
                coin in CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
}
