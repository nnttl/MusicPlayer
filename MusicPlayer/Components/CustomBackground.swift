//
//  CustomBackground.swift
//  MusicPlayer
//
//  Created by Natali Zhgenti on 11.12.25.
//

import SwiftUI

struct CustomBackground: View {
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [.customBlue.opacity(0.8), .black]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        }
    }
}

#Preview {
    CustomBackground()
}
