import SwiftUI

struct DrinkCard: View {
    let idDrink: String
    @ObservedObject var favoritesManager: FavoritesManager
    @State private var drink: Drink? = nil
    @State private var isLiked = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                if let drink = drink {
                    AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipped()
                    } placeholder: {
                        ProgressView() // Exibe um indicador de carregamento enquanto a imagem está sendo carregada
                            .frame(width: 150, height: 150, alignment: .center)
                    }
                }
                
                Button {
                    if isLiked {
                        favoritesManager.removeFavorite(drinkID: idDrink)
                    } else {
                        favoritesManager.addFavorite(drinkID: idDrink)
                    }
                    isLiked.toggle()
                } label: {
                    Image(systemName: "heart.fill")
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(isLiked ? Color(red: 0.5, green: 0, blue: 0.1) : .gray)
                        .background(.ultraThinMaterial)
                        .background(.gray)
                        .cornerRadius(50)
                        .padding(10)
                }
            }
            
            if let drink = drink {
                Text(drink.strDrink)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .frame(width: 150, height: 200)
        .background(Color("Principal"))
        .cornerRadius(20.0)
        .onAppear {
            Task {
                do {
                    drink = try await getDrinkId(id: idDrink).first
                    isLiked = favoritesManager.favorites.contains(idDrink)
                } catch {
                    print("Erro ao carregar drink: \(error)")
                }
            }
        }
    }
    
    func getDrinkId(id: String) async throws -> [Drink] {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw GHError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
            return drinkResponse.drinks
        } catch {
            throw GHError.invalidData
        }
    }
}


//
//#Preview {
//    Drinks()
//}
