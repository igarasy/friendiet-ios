import SwiftUI

struct ContentView: View {
    @StateObject private var foodManager = FoodTesteManager()
    
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .environmentObject(foodManager)  // Adicionando EnvironmentObject
                
                AddMealView()
                    .tabItem {
                        Label("Adicionar Refeição", systemImage: "plus")
                    }
                    .environmentObject(foodManager)  // Adicionando EnvironmentObject
                
                Text("Tela 2")
                    .tabItem {
                        Label("Configurações", systemImage: "gear")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
