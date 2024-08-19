import SwiftUI

struct AddMealView: View {
    @State private var navigationPath = NavigationPath()
    @EnvironmentObject var foodManager: FoodTesteManager
    
    // Define o layout da grid com duas colunas
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Text("Registre uma refeição")
                    .font(.headline)
                    .padding(.top)
                
                Text("Escolha entre as refeições salvas")
                    .font(.subheadline)
                    .padding(.bottom)
                
                // LazyVGrid para organizar os MealCards
                LazyVGrid(columns: columns, spacing: 10) {
                    MealCard()
                    MealCard()
                    MealCard()
                    MealCard()
                    MealCard()
                    MealCard()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                // Botão que altera o estado para mostrar a custom view
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
        }
    }
}

// Preview para visualização
struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView().environmentObject(FoodTesteManager())
    }
}
