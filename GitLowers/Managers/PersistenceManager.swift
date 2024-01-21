//
//  PersistenceManager.swift
//  GitLowers
//
//  Created by Nurbek on 22/01/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

struct PersistenceManager {
    
    static let shared = PersistenceManager()
    
    static private let defaults = UserDefaults.standard
    static private let key = "favorites"
    
    
    func updateWith(favorite: FollowersModel, actionType: PersistenceActionType, completed: @escaping (GLError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    func retrieveFavorites(completed: @escaping (Result<[FollowersModel], GLError>) -> Void) {
        guard let favoritesData = PersistenceManager.defaults.object(forKey: PersistenceManager.key) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FollowersModel].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    
    func save(favorites: [FollowersModel]) -> GLError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            PersistenceManager.defaults.set(encodedFavorites, forKey: PersistenceManager.key)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
}
