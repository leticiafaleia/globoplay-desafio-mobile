//
//  APIConstants.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 11/11/24.
//

import Foundation

struct APIConstants {
    static let apiBaseUrl = "https://api.themoviedb.org/3/"
    static let byGenre = "geren"
    static let byMovie = "movie/"
    static let byRecommendations = "/recommendations"
    static let byDiscover = "discover/movie"
    static let genrePath = "genre/movie/list"
    static let byPopularity = "&sort_by=popularity.desc"
    static let language = "&language=pt-BR"
    static let imageUrl = "https://image.tmdb.org/t/p/w185"
    static let page = "&page=1"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZGQ4OTkzOTdlNTk3NmMzZTM1ODYzM2Y1MDlkNDZmMyIsIm5iZiI6MTczMTUxMzQ1MC4zODEwNDU2LCJzdWIiOiI2NzJjYTUxZTQyYmVjNDk4Nzc4MGEyMWUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.wBDRjwbFK-8ZhuoOUBfsoEqDykV0ATepyVQrW3OxqY4"
    static let apiKey = "?api_key=ddd899397e5976c3e358633f509d46f3"
}
