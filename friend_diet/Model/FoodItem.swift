//
//  FoodItem.swift
//  friend_diet
//
//  Created by Lucas on 15/04/24.
//

import Foundation



class FoodManager: ObservableObject {
    @Published var foods: [Food] = []

    // Initializer to load foods from local storage when the manager is created
    init() {
        loadFromLocalStorage()
    }

    // Método para adicionar um novo alimento
    func addFood(_ food: Food) {
        foods.append(food)
        saveToLocalStorage()
    }

    // Método para salvar alimentos no armazenamento local
    private func saveToLocalStorage() {
        do {
            let data = try JSONEncoder().encode(foods)
            let url = getDocumentsDirectory().appendingPathComponent("foods.json")
            try data.write(to: url)
            print("Foods saved successfully")
        } catch {
            print("Failed to save foods: \(error.localizedDescription)")
        }
    }

    // Método para carregar alimentos do armazenamento local
    private func loadFromLocalStorage() {
        let url = getDocumentsDirectory().appendingPathComponent("foods.json")
        do {
            let data = try Data(contentsOf: url)
            foods = try JSONDecoder().decode([Food].self, from: data)
        } catch {
            print("Failed to load foods: \(error.localizedDescription)")
        }
    }

    // Método para obter o diretório de documentos do usuário, usado para armazenamento de dados
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct FoodItem: Codable, Identifiable {
    var id: UUID = UUID()
    var food: Food
    var quantity: Double // A quantidade do alimento
    
    init(food: Food, quantity: Double) {
        self.food = food
        self.quantity = quantity
    }
}

// Definição de um alimento, contendo informações nutricionais
struct Food: Codable, Identifiable {
    var id: UUID = UUID() // Identificador único
    var name: String
    var portion: Double?
    var calories: Double
    var fat: Double?
    var saturatedFat: Double?
    var transFat: Double?
    var cholesterol: Double?
    var sodium: Double?
    var carbohydrates: Double?
    var fiber: Double?
    var sugars: Double?
    var protein: Double
    var vitamins: [String: Double]? // Dicionário para armazenar vários tipos de vitaminas e seus valores
    var minerals: [String: Double]? // Dicionário para armazenar vários tipos de minerais e seus valores
}



// Classe para gerenciar as refeições e armazenar/recuperar do armazenamento local
class MealManager: ObservableObject {
    @Published var meals: [Meal] = []
    
    // Método para adicionar uma nova refeição
    func addMeal(_ meal: Meal) {
        meals.append(meal)
        saveToLocalStorage()
    }
    
    func addFood(_ quantifiedFood: FoodItem) {
        // For simplicity, we're directly saving the quantifiedFood
        // In a real app, you might want to add this to a meal or some other structure
        do {
            let data = try JSONEncoder().encode(quantifiedFood)
            let url = getDocumentsDirectory().appendingPathComponent("foodItem.json")
            try data.write(to: url)
            print("Food saved successfully")
        } catch {
            print("Failed to save food: \(error.localizedDescription)")
        }
    }
    
    // Método para salvar refeições no armazenamento local
    private func saveToLocalStorage() {
        do {
            let data = try JSONEncoder().encode(meals)
            let url = getDocumentsDirectory().appendingPathComponent("meals.json")
            try data.write(to: url)
        } catch {
            print("Failed to save meals: \(error.localizedDescription)")
        }
    }
    
    // Método para carregar refeições do armazenamento local
    private func loadFromLocalStorage() {
        let url = getDocumentsDirectory().appendingPathComponent("meals.json")
        do {
            let data = try Data(contentsOf: url)
            meals = try JSONDecoder().decode([Meal].self, from: data)
        } catch {
            print("Failed to load meals: \(error.localizedDescription)")
        }
    }
    
    // Método para obter o diretório de documentos do usuário, usado para armazenamento de dados
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}



