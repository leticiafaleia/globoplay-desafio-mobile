//
//  MyMovieList.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 13/11/24.
//

import Foundation

struct Mylist: Decodable{
    let id: Int
    let results: [ListMovie]
}

struct CreatedBy {
    let gravatarHash, id, name, username: String
}

struct ListMovie: Decodable {
    let id: Int
    let poster_path: String
}
