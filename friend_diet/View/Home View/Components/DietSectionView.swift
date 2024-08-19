//
//  DietSectionView.swift
//  friend_diet
//
//  Created by Lucas on 26/03/24.
//

import SwiftUI

struct DietSectionView: View {
    var body: some View {
            VStack {
                HStack{
                    Text("Dieta atual")
                    Spacer()
                    Image(systemName: "arrowshape.right.fill")
                }
                HStack{
                    VStack{
                        Text("Café da manhã")
                        Text("100g Tapioca").textScale(.secondary)
                        Text("50g Frango").textScale(.secondary)
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                    Spacer().frame(width: 40)
                    VStack{
                        Text("Almoço")
                        Text("150g Patinho").textScale(.secondary)
                        Text("200g Arroz").textScale(.secondary)
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                }
                HStack{
                    VStack{
                        Text("Café da tarde")
                        Text("150g Tapioca").textScale(.secondary)
                        Text("100g Frango").textScale(.secondary)
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                    Spacer().frame(width: 40)
                    VStack{
                        Text("Janta")
                        Text("150g Patinho").textScale(.secondary)
                        Text("200g Arroz").textScale(.secondary)
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                }
                HStack{
                    VStack{
                        Text("Ceia")
                        Text("30g Whey").textScale(.secondary)
                        Text("100g Aveia").textScale(.secondary)
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                    Spacer().frame(width: 40)
                    HStack{
                        Text("Adicionar refeição")
                        Image(systemName: "plus")
                        
                    }
                    .frame(width: 140, height: 90)
                    .background(Color.green.secondary)
                    .cornerRadius(10)
                }
                Spacer().frame(height: 10)
                HStack{
                    Spacer()
                    Text("Ver detalhes")
                    Image(systemName: "arrow.turn.down.right")
                       
                }
            }
            .padding()
            .frame(width: 360, height: 360)
            .background(Color.clear)
           
            .overlay( RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 3))
            .cornerRadius(10)
           
    }
}

#Preview {
    DietSectionView()
}
