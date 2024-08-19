//
//  TipCard.swift
//  friend_diet
//
//  Created by Lucas on 26/03/24.
//

import SwiftUI

struct TipCardView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
            Text(subtitle)
        }
        .containerRelativeFrame(.vertical, count: 1, spacing: 40)
        .frame(width: 360, height: 150)
        .background(Color.green.quaternary)
        .cornerRadius(10)
        .scrollTransition { content, phase in
            content.opacity(phase.isIdentity ? 1.0 : 0.5)
        }
    }
}

#Preview {
    TipCardView(title: "alo", subtitle: "olá")
}
