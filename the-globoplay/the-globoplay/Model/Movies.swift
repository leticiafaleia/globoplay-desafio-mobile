//
//  Movies.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 11/11/24.
//

import Foundation

struct Items: Encodable {
    let items: [listData]
}

struct listData: Encodable {
    let media_type: String
    let media_id: Int
}

struct Genres: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable{
    let id: Int
    let name: String
}

struct Movie: Decodable {
    let id: Int
    let poster_path: String
}

struct Root: Decodable {
    let results: [Movie]
}

struct MovieDetail: Decodable {
    let genres: [Genre]
    let id: Int
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_countries: [ProductionCountry]
    let release_date: String
    let runtime: Int
    let status, tagline, title: String
}

struct ProductionCountry: Decodable {
    let name: String
}
