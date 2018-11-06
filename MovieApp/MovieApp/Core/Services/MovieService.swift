//
//  MovieService.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getPopularMovies(onCompletion: @escaping (_ popularMovies: Transaction<[MovieEntity]>) -> Void )
}


class MovieService: MovieServiceProtocol {
    
    func getPopularMovies(onCompletion: @escaping (Transaction<[MovieEntity]>) -> Void) {
        //Mock data
        let movie1 = MovieEntity.init(name: "Venom", date: "October 5, 2018", description: "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego \"Venom\" to save his life.")
        let movie2 = MovieEntity.init(name: "Bohemian Rhapsody", date: "November 2, 2018", description: "Singer Freddie Mercury, guitarist Brian May, drummer Roger Taylor and bass guitarist John Deacon take the music world by storm when they form the rock 'n' roll band Queen in 1970. Hit songs become instant classics. When Mercury's increasingly wild lifestyle starts to spiral out of control, Queen soon faces its greatest challenge yet – finding a way to keep the band together amid the success and excess.")
        let arrayMovies: [MovieEntity] = [movie1, movie2, movie1, movie2]

        
        //API Request
        if let urlRequestUnwrapped = URL(string: APIConstant.popularMoviesEndPoint) {
            URLSession.shared.dataTask(with: urlRequestUnwrapped) { (data, response, error) in
                
                if error != nil{
                    print("Error \(String(describing: error))")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 401 {
                        print("Refresh token...")
                        return
                    }
                    
                }
                
                
                //Get data sucess
                
                
                
            }.resume()
            
        }
        
        //API Request
        
        
    
        
        onCompletion(Transaction.sucess(arrayMovies))
    }
    
}
