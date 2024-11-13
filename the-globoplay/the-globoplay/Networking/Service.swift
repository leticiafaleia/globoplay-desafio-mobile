//
//  Service.swift
//  the-globoplay
//
//  Created by Letícia Faleia on 07/11/24.
//

import Foundation

struct Service {
    func getMoviesByName(name: String, completion: @escaping (Root) -> Void) {
        let movieName = String(name)
        let searchURL = "https://api.themoviedb.org/3/search/keyword"
        
        guard let url = URL(string: searchURL + movieName) else { return }
        URLSession.shared.dataTask(with: url) {data, response, error in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let moviesData:Root = try JSONDecoder().decode(Root.self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesData)
                    }
                   
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
        
    func getMoviesByGenresRequest(with_genre: Int, completion: @escaping (Root) -> Void){
        let withGenre = String(with_genre)
        
        guard let url = URL(string: APIConstants.apiBaseUrl + APIConstants.byDiscover + APIConstants.apiKey + APIConstants.language + APIConstants.byPopularity + APIConstants.page + withGenre) else { return }
    
        URLSession.shared.dataTask(with: url) {data, response, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let moviesData:Root = try JSONDecoder().decode(Root.self, from: data)
                    DispatchQueue.main.async {
                        completion(moviesData)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func getMoviesGenresRequest (completion: @escaping(Genres) -> Void) {
        guard let url = URL(string: APIConstants.apiBaseUrl + APIConstants.genrePath + APIConstants.apiKey + APIConstants.language) else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let genres = try JSONDecoder().decode(Genres.self, from: data)
                    DispatchQueue.main.async {
                        completion(genres)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
        
    }
        func getMovieDetails(movieId: Int, completion: @escaping (MovieDetail) -> Void) {
        let id = String(movieId)

        guard let url = URL(string: APIConstants.apiBaseUrl + APIConstants.byMovie + id + APIConstants.apiKey + APIConstants.language) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(movieDetail)
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func getRecommendations(movieID: Int, completion: @escaping(Root) -> Void) {
        let movieID = String(movieID)
        
        guard let url = URL(string: APIConstants.apiBaseUrl + APIConstants.byMovie + movieID + APIConstants.byRecommendations + APIConstants.apiKey + APIConstants.language) else { return }
    
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let recommendations = try JSONDecoder().decode(Root.self, from: data)
                    DispatchQueue.main.async {
                        completion(recommendations)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func addMovieToList(movieId: Int, completion: @escaping(Int) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/4/list/8173428/items") else { return }
        var request = URLRequest(url: url)
        
        let listData = listData(media_type: "movie", media_id: movieId)
        let jsonObject = Items(items: [listData])
        
        do {
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(APIConstants.accessToken, forHTTPHeaderField: "Authorization")
            
            request.httpBody = try JSONEncoder().encode(jsonObject)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                let res = response as? HTTPURLResponse
                DispatchQueue.main.async {
                    if(error == nil) {
                        completion(res!.statusCode)
                    } else {
                        completion(440)
                    }
                }
            }.resume()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUserList(completion: @escaping(Mylist) -> Void) {
        let urlString = "https://api.themoviedb.org/4/list/8173428?page=1&api_key=ddd899397e5976c3e358633f509d46f3"

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIConstants.accessToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                guard let data = data else { return }

                do {
                    let myList = try JSONDecoder().decode(Mylist.self, from: data)
                    DispatchQueue.main.async {
                        completion(myList)
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            } else {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}
