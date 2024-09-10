import Foundation

class MealService {
    
    static let shared = MealService() // Singleton para uso global

    private init() {}
    
    func registerMeal(meal: MealTesteAAA, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/meals-consumed") else {
            print("URL inválida")
            return
        }

        let mealFoodsPayload = meal.mealFoods.map { mealFood in
            return [
                "mealFoodId": mealFood.mealFoodId,
                "quantidade": mealFood.quantidade ?? 0,
                "food": [
                    "foodId": mealFood.food.foodId,
                    "name": mealFood.food.nome
                ]
            ]
        }

        let payload: [String: Any] = [
            "userId": 1, // Use o ID do usuário apropriado
            "mealFoods": mealFoodsPayload
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
            print("Erro ao converter o payload para JSON")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Erro desconhecido", code: -1, userInfo: nil)))
                }
            }
        }.resume()
    }
}
