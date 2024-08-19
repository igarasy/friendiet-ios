//
//  HomeView.swift
//  friend_diet
//
//  Created by Lucas on 26/03/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Spacer().frame(height: 10)
                TipCarouselView()
                Spacer().frame(height: 10)
                CaloriesRingView()
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                RecentMealsListView()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}

struct CaloriesRingView: View {
    let consumedCalories: Double = 800
    let burnedCalories: Double = 500
    let totalCalories: Double
    
    init() {
        totalCalories = consumedCalories - burnedCalories
    }
    
    var body: some View {
        VStack {
            ZStack {
                RingView(color: .red, size: 200, percentage: consumedCalories / 1000)
                RingView(color: .green, size: 160, percentage: burnedCalories / 1000)
                RingView(color: .blue, size: 120, percentage: totalCalories / 1000)
            }
            .padding()
            Spacer().frame(height: 10)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Consumidas: \(consumedCalories, specifier: "%.0f")")
                        Spacer()
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                    HStack {
                        Text("Queimadas: \(burnedCalories, specifier: "%.0f")")
                        Spacer()
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10, height: 10)
                    }
                    HStack {
                        Text("Restantes: \(totalCalories, specifier: "%.0f")")
                        Spacer()
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                    }
                }
                Spacer()
            }
            .padding(.leading) // Adiciona um pouco de espaçamento à esquerda
        }
    }
}

struct RingView: View {
    var color: Color
    var size: CGFloat
    var percentage: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(color)
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(percentage, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: size, height: size)
                .animation(.linear)
        }
    }
}
