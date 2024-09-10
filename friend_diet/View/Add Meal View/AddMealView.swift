import SwiftUI

struct AddMealView: View {
    @State private var navigationPath = NavigationPath()
    @EnvironmentObject var foodManager: FoodTesteManager
    @State private var diets: [Diet] = []
    @State private var selectedDiet: Diet?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                if !diets.isEmpty {
                    Picker("Selecione uma dieta", selection: $selectedDiet) {
                        ForEach(diets, id: \.dietId) { diet in
                            Text(diet.name).tag(diet as Diet?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                } else {
                    Text("Carregando dietas...")
                }
                
                Text("Registre uma refeição")
                    .font(.headline)
                    .padding(.top)
                
                Text("Escolha entre as refeições salvas")
                    .font(.subheadline)
                    .padding(.bottom)
                
                if let selectedDiet = selectedDiet, !selectedDiet.meals.isEmpty {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(selectedDiet.meals, id: \.mealId) { meal in
                            MealCard(meal: meal, onRegister: registerMeal)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                } else {
                    Text("Nenhuma refeição disponível")
                }
                
                Button("Adicionar refeição personalizada") {
                    navigationPath.append("CustomMeal")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.green.quaternary)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationDestination(for: String.self) { value in
                if value == "CustomMeal" {
                    AddCustomMealView()
                }
            }
            .onAppear(perform: loadDiets) // Usa a função de carregar dietas
        }
    }
    
    func loadDiets() {
        DietService.shared.fetchDiets(userId: 1) { result in
            switch result {
            case .success(let fetchedDiets):
                self.diets = fetchedDiets.filter { !$0.meals.isEmpty }
                self.selectedDiet = fetchedDiets.first // Seleciona a primeira dieta por padrão
            case .failure(let error):
                print("Erro ao carregar dietas: \(error)")
            }
        }
    }

    func registerMeal(_ meal: MealTesteAAA) {
        MealService.shared.registerMeal(meal: meal) { result in
            switch result {
            case .success:
                print("Refeição registrada com sucesso")
            case .failure(let error):
                print("Erro ao registrar a refeição: \(error)")
            }
        }
    }
}

// Preview para visualização
struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView().environmentObject(FoodTesteManager())
    }
}


// Model para representar uma dieta
struct Diet: Identifiable, Decodable, Hashable {
    var id: Int { dietId }
    let dietId: Int
    let name: String
    let description: String?
    let meals: [MealTesteAAA] // Certifique-se de que `MealTesteAAA` seja `Hashable` também
}

// Supondo que `MealTesteAAA` seja semelhante a `Meal` no exemplo anterior
struct MealTesteAAA: Decodable, Hashable, Equatable {
    let mealId: Int
    let mealDate: String?
    let mealTime: String?
    let comment: String?
    let mealFoods: [MealFoodAAA]
}


struct User: Codable {
    let userId: Int
}

struct FoodAAA: Decodable, Hashable, Equatable {
    let foodId: Int
    let nome: String
    let energiaKcal: Double
    let proteina: Double
    let lipidios: Double?
    let colesterol: Double?
    let carboidrato: Double?
    let fibraAlimentar: Double?
    let cinzas: Double?
    let calcio: Double?
    let magnesio: Double?
    let manganes: Double?
    let fosforo: Double?
    let ferro: Double?
    let sodio: Double?
    let potassio: Double
    let cobre: Double?
    let zinco: Double?
    let vitaminaC: Double?
}

struct MealFoodAAA: Decodable, Hashable, Equatable {
    let mealFoodId: Int
    let quantidade: Double?
    let food: FoodAAA
    let comment: String?
}


struct MealConsumed: Identifiable, Decodable {
    let id: Int
    let createdAt: Date
    let comment: String?
    let mealFoods: [MealFoodAAA]
    
    // Propriedade calculada para totalCalories
    var totalCalories: Int {
        mealFoods.reduce(0) { sum, food in
            sum + Int(food.food.energiaKcal)
        }
    }
}
