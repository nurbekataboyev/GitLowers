//
//  FollowersInfoModel.swift
//  GitLowers
//
//  Created by Nurbek on 19/01/24.
//

import Foundation

struct UserInfoModel: Codable {
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: Date
    
    var name: String?
    var location: String?
    var bio: String?
}
