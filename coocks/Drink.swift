import Foundation

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

// Modelo simplificado para o drink
struct Drink: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
    let strGlass: String
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    
    
    
    // Método que organiza os ingredientes e medidas
    func getIngredientes() -> [(String, String)] {
        var ingredientes: [(String, String)] = []

        let allIngredients = [
            (strIngredient1, strMeasure1),
            (strIngredient2, strMeasure2),
            (strIngredient3, strMeasure3),
            (strIngredient4, strMeasure4),
            (strIngredient5, strMeasure5),
            (strIngredient6, strMeasure6),
            (strIngredient7, strMeasure7),
            (strIngredient8, strMeasure8),
            (strIngredient9, strMeasure9),
            (strIngredient10, strMeasure10),
            (strIngredient11, strMeasure11),
            (strIngredient12, strMeasure12),
            (strIngredient13, strMeasure13),
            (strIngredient14, strMeasure14),
            (strIngredient15, strMeasure15)
        ]

        for (ingredient, measure) in allIngredients {
            if let ingredient = ingredient, !ingredient.isEmpty {
                if let measure = measure, !measure.isEmpty {
                    ingredientes.append(contentsOf: [(measure, ingredient)])
                } else {
                    ingredientes.append(contentsOf: [("to taste", ingredient)])
                }
            }
        }
        print(ingredientes)
        return ingredientes
    }
}

func getAllDrink(caracter: String) async throws -> [Drink] {
    
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=\(caracter)") else {
        throw GHError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do{
        let decoder = JSONDecoder()
        let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    }
    catch{
        throw GHError.invalidData
    }
}


func getDrink(name: String) async throws -> [Drink] {
    guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(name)") else {
        throw GHError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do{
        let decoder = JSONDecoder()
        let drinkResponse = try decoder.decode(DrinkResponse.self, from: data)
        return drinkResponse.drinks
    }
    catch{
        throw GHError.invalidData
    }
}
enum GHError: Error {
case invalidURL
    case invalidResponse
    case invalidData
}


//converter a quantidade para número
func converterParaNumero(_ string: String) -> (valor: Double, unidade: String)? {
    //verifica se o ultimo caracter é " ", se sim exclui ele
    var texto = string
    if texto.last == " " {
        texto = String(texto.dropLast())
    }
    // Separar o valor numérico e a unidade
    let componentes = texto.components(separatedBy: " ")
    var valorTotal: Double = 0.0
    var unidade: String = ""

    for componente in componentes {
        if componente.contains("/") {
            // Se for uma fração, dividimos para obter o valor decimal
            let partes = componente.split(separator: "/").compactMap { Double($0) }
            if partes.count == 2 {
                valorTotal += partes[0] / partes[1]
            }
        } else if let numero = Double(componente) {
            // Se for um número inteiro ou decimal, somamos ao total
            valorTotal += numero
        } else {
            // Verifica se é uma unidade
            unidade = componente
        }
    }
    valorTotal = (valorTotal * 100).rounded() / 100
    // Retorna o valor total e a unidade
    return (valor: valorTotal, unidade: unidade)
}
