//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by KOFI on 5/17/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername    = "This username created an Invalid request. Please try again"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data recieved from the server was invalid. Please try again"
    case unableToFavorites  = "An error occured favoriting this user"
    case memberFavorited    = "This user has been favorited already 😊"
}
