//
//  CIrcleButtonAnimationVIew.swift
//  trading
//
//  Created by Mayank Dev on 08/07/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool

        var body: some View {
            Circle()
                .stroke(lineWidth: 5.0)
                .scaleEffect(animate ? 1 : 0)
                .opacity(animate ? 0 : 1)
                .animation(.easeInOut(duration: animate ? 0 : 1), value: animate)
    
        }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundColor(.red)
        .frame(width: 100, height: 100)
        
}
