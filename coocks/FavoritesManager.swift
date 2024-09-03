//
//  FavoritesManager.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 02/09/24.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    @Published var favorites: [String] {
        didSet {
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
    }
    
    init() {
        self.favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    }
    
    func addFavorite(drinkID: String) {
        if !favorites.contains(drinkID) {
            favorites.append(drinkID)
        }
    }
    
    func removeFavorite(drinkID: String) {
        if let index = favorites.firstIndex(of: drinkID) {
            favorites.remove(at: index)
        }
    }
}


