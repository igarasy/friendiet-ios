import SwiftUI

struct MealCard: View {
    var meal: MealTesteAAA
    var onRegister: (MealTesteAAA) -> Void // Função de callback para registrar a refeição
    
    var body: some View {
        Button(action: {
            onRegister(meal) // Chama a função de registro quando o botão é clicado
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(meal.comment ?? "Refeição")
                    ForEach(meal.mealFoods.prefix(2), id: \.mealFoodId) { mealFood in
                        let quantidadeFormatted = String(format: "%.0f", mealFood.quantidade ?? 0)
                        Text("\(quantidadeFormatted)g \(mealFood.food.nome)")
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .textScale(.secondary)
                    }
                }
                .frame(width: 140, height: 90)
                .background(Color.green.secondary)
                .cornerRadius(10)
            }
        }
        .foregroundStyle(.black)
    }
}

// Preview para visualizar o MealCard
#Preview {
    MealCard(
        meal: MealTesteAAA(
            mealId: 1,
            mealDate: nil,
            mealTime: nil,
            comment: "Café da manhã",
            mealFoods: [
                MealFoodAAA(
                    mealFoodId: 1,
                    quantidade: 1,
                    food: FoodAAA(
                        foodId: 1,
                        nome: "Tapioca",
                        energiaKcal: 123.535,
                        proteina: 2.58825,
                        lipidios: 1,
                        colesterol: 1,
                        carboidrato: 25.8097,
                        fibraAlimentar: 2.74933,
                        cinzas: 0.463,
                        calcio: 5.204,
                        magnesio: 58.702,
                        manganes: 0.627333,
                        fosforo: 105.853,
                        ferro: 0.262,
                        sodio: 1,
                        potassio: 75.1517,
                        cobre: 0.0203333,
                        zinco: 0.682667,
                        vitaminaC: 1
                    ), comment: "Almoço"
                )
            ]
        ),
        onRegister: { _ in }
    )
}
