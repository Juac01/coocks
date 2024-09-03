import SwiftUI

// View principal que exibe a lista de bebidas
struct SearchView: View {
    @State private var drinks: [Drink] = []
    @State private var searchText: String = ""
    @State private var isLoading = false
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    
    private let caracters = Array(97...122).compactMap { UnicodeScalar($0) }
    
    // Mapeamento de bebidas por caractere
    @State private var drinksByCharacter: [Character: [Drink]] = [:]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        if searchText.isEmpty {
                            ForEach(caracters, id: \.self) { scalar in
                                VStack(alignment: .leading) {
                                    Text(String(scalar).uppercased())
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.leading, 25.0)
                                        
                                    if isLoading {
                                        ProgressView()
                                            .padding()
                                    } else {
                                        LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                                            if let drinksForCharacter = drinksByCharacter[Character(scalar)] {
                                                ListCocktailsView(listDrinks: drinksForCharacter)
                                            }
                                        }
                                    }
                                }
                                .task {
                                    await loadDrinks(for: Character(scalar))
                                }
                            }
                        } else {
                            LazyVGrid(columns: adaptiveColumn, spacing: 10) {
                                ListCocktailsView(listDrinks: drinks)
                            }
                            .padding()
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                Task {
                    await searchDrinks()
                }
            }
            .task {
                if searchText.isEmpty {
                    // Carregar bebidas iniciais quando a tela for aberta
                    await loadInitialDrinks()
                }
            }
        }
    }
    
    private func loadInitialDrinks() async {
        isLoading = true
        do {
            // Carregar bebidas para todos os caracteres
            for caracter in caracters {
                await loadDrinks(for: Character(caracter))
            }
        } catch {
            print("Erro ao carregar bebidas iniciais: \(error)")
        }
        isLoading = false
    }
    
    private func searchDrinks() async {
        isLoading = true
        do {
            drinks = try await getDrink(name: searchText)
        } catch {
            print("Erro ao pesquisar bebidas: \(error)")
        }
        isLoading = false
    }
    
    private func loadDrinks(for caracter: Character) async {
        do {
            let scalar = String(caracter)
            let fetchedDrinks = try await getAllDrink(caracter: scalar)
            // Atualizar o dicionário de bebidas por caractere
            drinksByCharacter[caracter] = fetchedDrinks
        } catch {
            print("Erro ao carregar bebidas para \(caracter): \(error)")
        }
    }
    
}

// Preview da ContentView
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
