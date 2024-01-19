//
//  FollowersModel.swift
//  GitLowers
//
//  Created by Nurbek on 17/01/24.
//

import Foundation

struct FollowersModel: Codable, Hashable {
    var login: String
    var avatarUrl: String
}

enum Section: Hashable {
    case main
}
