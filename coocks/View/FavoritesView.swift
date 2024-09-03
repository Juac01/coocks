//
//  FavoritesView.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 30/08/24.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var favoritesManager = FavoritesManager()
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumn, spacing: 8) {
                ForEach(favoritesManager.favorites, id: \.self) { favorit in
                    DrinkCard(idDrink: favorit, favoritesManager: favoritesManager)
                }
            }
            .padding()
        }
    }
}

#Preview {
    FavoritesView()
}


#Preview {
    FavoritesView()
}

