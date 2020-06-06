//
//  User.swift
//  GHFollowers
//
//  Created by KOFI on 5/17/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let createdAt: String
}
