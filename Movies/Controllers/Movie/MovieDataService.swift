//
//  MovieDataServices.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/2/20.
//

import Foundation

class MovieDataService {
    
    func fetchMovies(completion: @escaping ((Results?, Error?) -> Void)) {
        
        //
        let api_key = "70fdc27d7050fded676fee33ef2defd9"
        let language = "es-Es"
        let page = 1
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api_key)&language=\(language)&page=\(page)")!
        
        //
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, eror) in
            
            do {
                
                let movie = try JSONDecoder().decode(Results.self, from: data!)
                completion(movie, nil)
            } catch let error {
                print(error)
                completion(nil, error)
            }
            
        }

        task.resume()
    }
    
    func fetchActor(movie id: Int, completion: @escaping ((Actor?, Error?) -> Void)) {
        
        //
        let api_key = "70fdc27d7050fded676fee33ef2defd9"
        let language = "es-Es"
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(api_key)&language=\(language)")!
        
        //
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, eror) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                let actor = try JSONDecoder().decode(Actor.self, from: data!)
                completion(actor, nil)
            } catch let error {
                print(error)
                completion(nil, error)
            }
            
        }

        task.resume()
    }
    
    
}
