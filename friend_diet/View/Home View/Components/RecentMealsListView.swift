import SwiftUI

struct MealTeste: Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
    let date: Date
}

struct RecentMealsListView: View {
    let meals: [MealTeste] = [
        MealTeste(name: "Café da Manhã", calories: 300, date: Date()),
        MealTeste(name: "Almoço", calories: 600, date: Date()),
        MealTeste(name: "Jantar", calories: 500, date: Date())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ÚLTIMAS REFEIÇÕES")
                .font(.headline)
                .padding(.leading)
                .padding(.top)
            
            VStack {
                ForEach(meals) { meal in
                    MealRow(meal: meal)
                    Divider()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MealRow: View {
    let meal: MealTeste
    
    var body: some View {
        HStack {
            Image(systemName: "fork.knife.circle") // Placeholder image
                .resizable()
                .padding(4)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.body)
                    .fontWeight(.bold)
                Text("\(meal.date, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(meal.calories) KCal")
                .font(.body)
                .fontWeight(.bold)
        }
        .padding(.vertical, 5)
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMealsListView()
    }
}
