//
//  Model.swift
//  TryFastAPI
//
//  Created by Weerawut Chaiyasomboon on 8/1/2568 BE.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let accessToken: String
    let tokenType: String
}

struct Todos: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let priority: Int
    let complete: Bool
    let ownerId: Int
}
