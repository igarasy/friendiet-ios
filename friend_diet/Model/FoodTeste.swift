//
//  FoodTeste.swift
//  friend_diet
//
//  Created by Lucas on 16/04/24.
//

import Foundation

struct FoodTeste: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var portion: Double?
}

class FoodTesteManager: ObservableObject {
    @Published var foods: [FoodTeste] = []

    // Initializer to load foods from local storage when the manager is created
    init() {
        loadFromLocalStorage()
    }

    // Método para adicionar um novo alimento
    func addFood(_ food: FoodTeste) {
        objectWillChange.send()
        foods.append(food)
        saveToLocalStorage()
    }

    // Método para salvar alimentos no armazenamento local
    internal func saveToLocalStorage() {
        do {
            let data = try JSONEncoder().encode(foods)
            let url = getDocumentsDirectory().appendingPathComponent("foodsTeste.json")
            try data.write(to: url)
            print("Foods saved successfully")
        } catch {
            print("Failed to save foods: \(error.localizedDescription)")
        }
    }

    // Método para carregar alimentos do armazenamento local
    private func loadFromLocalStorage() {
        let url = getDocumentsDirectory().appendingPathComponent("foodsTeste.json")
        do {
            let data = try Data(contentsOf: url)
            foods = try JSONDecoder().decode([FoodTeste].self, from: data)
        } catch {
            print("Failed to load foods: \(error.localizedDescription)")
        }
    }

    // Método para obter o diretório de documentos do usuário, usado para armazenamento de dados
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

