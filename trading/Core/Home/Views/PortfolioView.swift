//
//  PortfolioView.swift
//  trading
//
//  Created by Mayank Dev on 16/07/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Portfolio")
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Text("Edit Portfolio")
                        .font(.system(size: 30,weight: .bold))
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action:{
                        self.isPresented = false
                    }){
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                })
            })
            .padding()
        }
    }
}

#Preview {
    PortfolioView(isPresented: .constant(true))
}
