import Foundation
import Combine

class RecentMealsViewModel: ObservableObject {
    @Published var mealsConsumed: [MealConsumed] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let mealConsumedService = MealConsumedService()
    private var cancellables = Set<AnyCancellable>()

    func fetchMealsConsumed(for userId: Int, completion: @escaping (Result<[MealConsumed], Error>) -> Void) {
        isLoading = true
        errorMessage = nil
        
        mealConsumedService.fetchMealsConsumed(for: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let meals):
                    // Filtra refeições que possuem mealFoods com 1 ou mais itens
                    let mealConsumedList = meals
                        .filter { $0.mealFoods.count >= 1 } // Mantém apenas refeições com 1 ou mais itens
                        .map { meal -> MealConsumed in
                            // Use createdAt diretamente, sem conversão
                            let date = meal.createdAt
                            let comment = meal.comment
                            
                            return MealConsumed(
                                id: meal.id,
                                createdAt: date,
                                comment: comment,
                                mealFoods: meal.mealFoods
                            )
                        }
                    
                    self?.mealsConsumed = mealConsumedList
                    completion(.success(mealConsumedList))
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
            }
        }
    }
}

