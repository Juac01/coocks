//
//  ListCocktailsView.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 02/09/24.
//

import SwiftUI

struct ListCocktailsView: View {
    let listDrinks: [Drink]
    @StateObject private var favoritesManager = FavoritesManager()
        
    var body: some View {
        ForEach(listDrinks, id: \.strDrink) { drink in
            NavigationLink(destination: RecipeView(
                name: drink.strDrink,
                image: drink.strDrinkThumb,
                glass: drink.strGlass,
                preparo: drink.strInstructions,
                ingredientes: drink.getIngredientes())) {
                    DrinkCard(idDrink: drink.idDrink, favoritesManager: favoritesManager)
                }
        }
    }
}

