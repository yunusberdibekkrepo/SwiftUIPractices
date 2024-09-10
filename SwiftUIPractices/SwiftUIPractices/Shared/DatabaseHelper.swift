//
//  DatabaseHelper.swift
//  SwiftUIPractices
//
//  Created by Yunus Emre Berdibek on 11.04.2024.
//

import Foundation

struct DatabaseHelper {
    func getproducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductArray.self, from: data)

        return products.products
    }

    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)

        return users.users
    }
}

