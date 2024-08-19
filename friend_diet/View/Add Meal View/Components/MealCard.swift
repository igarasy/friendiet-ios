//
//  MealCard.swift
//  friend_diet
//
//  Created by Lucas on 29/07/24.
//

import SwiftUI

struct MealCard: View {
    var body: some View {
        Button(action: {
            print("Café da manhã clicado")
        }) {
            HStack{
                VStack{
                    Text("Café da manhã")
                    Text("100g Tapioca").textScale(.secondary)
                    Text("50g Frango").textScale(.secondary)
                }
                .frame(width: 140, height: 90)
                .background(Color.green.secondary)
                .cornerRadius(10)
            }
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    MealCard()
}
