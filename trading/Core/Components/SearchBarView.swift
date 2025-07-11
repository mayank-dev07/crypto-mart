//
//  SearchBarView.swift
//  trading
//
//  Created by Mayank Dev on 12/07/25.
//

import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText :
                    Color.theme.accent
                    )
            TextField("Search", text: $searchText)
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
            }
        }
                .font(.headline)
                .foregroundColor(Color.theme.accent)                
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.theme.background)
                        .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
                )
                .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
