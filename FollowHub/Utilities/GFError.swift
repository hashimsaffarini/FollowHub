//
//  ErrorMessage.swift
//  FollowHub
//
//  Created by Hashim Saffarini on 22/10/2025.
//

enum GFError : String, Error {
    case invalidUsername = "This username created invalid request. please try again!"
    case unableToComplete = "Unable to complete your request. please check your internet connection"
    case invalidResponse = "Invalid response from the server. please try again"
    case invalidData = "The data recived from the server was invalid. please try again"
}
