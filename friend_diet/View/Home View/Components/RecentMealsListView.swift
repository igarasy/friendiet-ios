import SwiftUI

struct RecentMealsListView: View {
    @ObservedObject var viewModel: RecentMealsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ÚLTIMAS REFEIÇÕES")
                .font(.headline)
                .padding(.leading)
                .padding(.top)
            
            if viewModel.isLoading {
                ProgressView("Carregando refeições...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack {
                    ForEach(viewModel.mealsConsumed) { meal in
                        MealRow(meal: meal)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.fetchMealsConsumed(for: 1){
                result in
            }
        }
    }
}

struct MealRow: View {
    let meal: MealConsumed
    
    var body: some View {
        HStack {
            Image(systemName: "fork.knife.circle") // Placeholder image
                .resizable()
                .padding(4)
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(meal.comment ?? "")
                    .font(.body)
                    .fontWeight(.bold)
                
                Text("\(isoDateFormatter.string(from: meal.createdAt))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(meal.totalCalories) KCal")
                .font(.body)
                .fontWeight(.bold)
        }
        .padding(.vertical, 5)
    }
}

let isoDateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
}()


struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMealsListView(viewModel: RecentMealsViewModel())
    }
}
