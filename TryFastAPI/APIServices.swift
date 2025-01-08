//
//  APIServices.swift
//  TryFastAPI
//
//  Created by Weerawut Chaiyasomboon on 8/1/2568 BE.
//

import Foundation

enum APIError: Error {
    case endpointError
    case responseError
    case notGetToken
}

@Observable
class APIServices {
    static let shared = APIServices()
    private init() {}
    
    var token: String?
    
    func login(username: String, password: String) async throws {
        let endpoint = "http://127.0.0.1:8000/auth/me/token"
        guard let url = URL(string: endpoint) else {
            throw APIError.endpointError
        }
        
        let loginRequest = LoginRequest(username: username.lowercased(), password: password.lowercased())
        let encoder = JSONEncoder()
        let body = try encoder.encode(loginRequest)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let (responseData,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw APIError.responseError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let jsonResponse = try decoder.decode(LoginResponse.self, from: responseData)
        
        self.token = jsonResponse.accessToken
        print(self.token!)
    }
    
    func getTodos() async throws -> [Todos] {
        let endpoint = "http://127.0.0.1:8000/"
        guard let url = URL(string: endpoint) else {
            throw APIError.endpointError
        }
        
        guard let token = self.token else {
            throw APIError.notGetToken
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.responseError
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Todos].self, from: data)
    }
}
