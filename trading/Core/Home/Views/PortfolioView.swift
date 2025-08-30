//
//  PortfolioView.swift
//  trading
//
//  Created by Mayank Dev on 16/07/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PortfolioView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showSaveIcon: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinListView
                    
                    if selectedCoin != nil {
                     portfolioInputSection
                    }
                 
                }
                
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action:{
                        self.isPresented = false
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action:{
                        self.isPresented = false
                    }){
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Save".uppercased())
                    }.disabled(quantityText.isEmpty)
                })
            })
//            .onChange(of:vm.searchText, perform:{value in
//                if  value == ""{
//                    removeSelectedCoin()
//                }
//            })
        }
    }
}

#Preview {
    PortfolioView(isPresented: .constant(true))
        .environmentObject(HomeViewModel())
}

extension PortfolioView {
    
    private var coinListView: some View {
        ScrollView(.horizontal, showsIndicators: true, content: {
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .onTapGesture {
                            selectedCoin = coin
                        }
                }.padding(.horizontal, 5)
            }
            .padding(.leading)

        })
    }
    
    private func getCurrentAmmount() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.14", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Amount")
                Spacer()
                Text(getCurrentAmmount().asCurrencyWith2Decimals())
            }
        }
        .padding()
        .font(.headline)
    }
    
    
        private func saveButtonPressed(){
            guard let coin = selectedCoin else { return }
    //        return quantityText.isEmpty
            
//show checkmark
            withAnimation(.easeIn){
                showSaveIcon = true
                removeSelectedCoin()
            }
            
//            hide keyboard
            UIApplication.shared.endEditing()
        }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        
    }
}



