import SwiftUI

struct AddCustomMealView: View {
    @EnvironmentObject var foodManager: FoodTesteManager
    @State private var mealName: String = ""
    @State private var portionSelections = [UUID: Int]()
    
    var body: some View {
        VStack {
            Text("Registre uma refeição")
                .font(.title)
                .foregroundStyle(.primary)
            
            Spacer().frame(height: 20)
            
            TextField("Nome do alimento", text: $mealName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            List {
                ForEach(foodManager.foods.indices, id: \.self) { index in
                    let food = foodManager.foods[index]
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(food.name)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            
                            Picker("Porção: \(portionSelections[food.id, default: 100]) g", selection: Binding(
                                get: { self.portionSelections[food.id, default: 100] },
                                set: { newValue in
                                    self.portionSelections[food.id] = newValue
                                    foodManager.updatePortion(for: food.id, with: newValue)
                                }
                            )) {
                                ForEach(1...200, id: \.self) { number in
                                    Text("\(number) g").tag(number)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 110)
                            .clipped()
                            Spacer().frame(width: 300)
                        }
                        .padding()
                        .background(Color.green.quaternary)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding([.top, .bottom], 8)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Remover") {
                                guard let index = foodManager.foods.firstIndex(where: { $0.id == food.id }) else { return }
                                foodManager.removeFood(atOffsets: IndexSet(integer: index))
                            }
                            .tint(.red).opacity(0.2)
                        }
                    }
                    .background(Color.green.quaternary)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
            Button(action: submitMeal) {
                Text("Adicionar alimento")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.green.quaternary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(mealName.isEmpty)
            Spacer().frame(height: 10)
            Button(action: submitMeal) {
                Text("Registrar refeição")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(mealName.isEmpty)
        }
        
    }
    
    func deleteFood(at offsets: IndexSet) {
        foodManager.removeFood(atOffsets: offsets)
    }
    
    func submitMeal() {
        let newPortion = Double(portionSelections.values.first ?? 100) // Default to 100 if nothing selected
        let newFood = FoodTeste(name: mealName, portion: newPortion)
        foodManager.addFood(newFood)
    }
}

extension FoodTesteManager {
    func updatePortion(for foodId: UUID, with portion: Int) {
        if let index = foods.firstIndex(where: { $0.id == foodId }) {
            foods[index].portion = Double(portion)
            saveToLocalStorage()
        }
    }
    
    func removeFood(atOffsets offsets: IndexSet) {
        objectWillChange.send()
        foods.remove(atOffsets: offsets)
        saveToLocalStorage()
    }
}

struct AddCustomMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomMealView().environmentObject(FoodTesteManager())
    }
}
