//
//  ImageApi.swift
//  UnsplashTestProject
//
//  Created by NODIR KARIMOV on 18/01/22.
//

import UIKit

struct ImageModel: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLs
    let likes: Int
    let user: User
}

struct URLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
}

struct User: Codable {
    let first_name: String
    let location: String?
}

