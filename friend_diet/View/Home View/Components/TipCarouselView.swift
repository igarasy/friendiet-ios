//
//  TipCarousel.swift
//  friend_diet
//
//  Created by Lucas on 26/03/24.
//

import SwiftUI

struct TipCarouselView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                ForEach(MockData){
                    item in VStack {
                        TipCardView(title: item.title, subtitle: item.subtitle)
                    }
                }
            }
        }
        .frame(height: 160)
        .contentMargins(10, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    TipCarouselView()
}
