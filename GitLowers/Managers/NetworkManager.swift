//
//  NetworkManager.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getFollowers(forUser username: String, page: Int) async throws -> [FollowersModel] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GLError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GLError.invalidResponse
        }
        
        do {
            return try decoder.decode([FollowersModel].self, from: data)
        } catch {
            throw GLError.invalidData
        }
    }
    
    
    func getUserInfo(forUsername username: String) async throws -> UserInfoModel {
        let endpoint = baseURL + username
        
        guard let url = URL(string: endpoint) else {
            throw GLError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GLError.invalidResponse
        }
        
        do {
            return try decoder.decode(UserInfoModel.self, from: data)
        } catch {
            throw GLError.invalidData
        }
    }
    
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
