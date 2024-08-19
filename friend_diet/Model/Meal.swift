//
//  Meal.swift
//  friend_diet
//
//  Created by Lucas on 15/04/24.
//

import Foundation

// Definição de uma refeição, contendo diferentes alimentos
struct Meal: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var date: Date = Date() // Data e hora da refeição
    var foodItems: [Food] // Lista de alimentos na refeição
}
