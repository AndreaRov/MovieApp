//
//  MovieService.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getCurrentPopularMovies(completion: @escaping (Transaction<[PopularMovieEntity]>) -> Void)
    func getMovieDetails(movieId: Int, completion: @escaping (Transaction<MovieDetailsEntity>) -> Void)
}

class MovieService: MovieServiceProtocol {

    let apiClient: TheMovieDataBaseAPIClientProtocol
    
    init(apiClient: TheMovieDataBaseAPIClient) {
        self.apiClient = apiClient
    }
    
    
    internal func getCurrentPopularMovies(completion: @escaping (Transaction<[PopularMovieEntity]>) -> Void) {
        
        apiClient.read(GetPopularMoviesRequest(), DecodableType.PopularMoviesResponseEntity) { (transaction) in
            switch transaction {
                
            case .sucess(let data):
                if let dataUnwrapped = data as? [PopularMovieEntity] {
                    completion(Transaction.sucess(dataUnwrapped))
                } else {
                    completion(Transaction.fail(TransactionError.expectedPopularMovieEntity))
                }
            case .fail(let error):
                completion(Transaction.fail(error))
            }
        }
    }
    
    internal func getMovieDetails(movieId: Int, completion: @escaping (Transaction<MovieDetailsEntity>) -> Void) {
        
        apiClient.read(GetDetailsMovieRequest(movieId: movieId), DecodableType.MovieDetailsEntity) { (transaction) in
            
            switch transaction {
            case .sucess(let data):
                if let dataUnwrapped = data as? MovieDetailsEntity {
                    completion(Transaction.sucess(dataUnwrapped))
                } else {
                    completion(Transaction.fail(TransactionError.expectedPopularMovieEntity))
                }
            case .fail(let error):
                completion(Transaction.fail(error))
            }
            
            
        }
        
    }
    
    
}
