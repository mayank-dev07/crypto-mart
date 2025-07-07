//
//  HomeView.swift
//  trading
//
//  Created by Mayank Dev on 08/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color.theme.background
                .ignoresSafeArea()
            

            VStack {
                
                HStack {
                    CircleButtonView(iconName: showPortfolio ? "info" : "plus")
                       
                    Spacer()
                    Text("Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
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
                Spacer(minLength: 0)
            }
        }
    }
}


#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}
