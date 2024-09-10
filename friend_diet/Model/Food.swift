//
//  Food.swift
//  friend_diet
//
//  Created by Lucas on 26/08/24.
//

import Foundation

struct Food: Decodable {
    let foodId: Int
    let nome: String
    let energiaKcal: Double
    let proteina: Double
    let lipidios: Double?
    let colesterol: Double?
    let carboidrato: Double
    let fibraAlimentar: Double
    let cinzas: Double?
    let calcio: Double
    let magnesio: Double
    let manganes: Double
    let fosforo: Double
    let ferro: Double
    let sodio: Double?
    let potassio: Double
    let cobre: Double?
    let zinco: Double
    let vitaminaC: Double?
}
