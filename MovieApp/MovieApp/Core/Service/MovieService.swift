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
    func getMovieVideos(movieId: Int, completion: @escaping (Transaction<[VideosEntity]>) -> Void)
}

class MovieService: MovieServiceProtocol {

    let apiClient: TheMovieDataBaseAPIClientProtocol
    
    init(apiClient: TheMovieDataBaseAPIClient) {
        self.apiClient = apiClient
    }
    
    
    internal func getCurrentPopularMovies(completion: @escaping (Transaction<[PopularMovieEntity]>) -> Void) {
        
        apiClient.readWithURL(GetPopularMoviesRequest(), URLDecodableType.PopularMoviesResponseEntity) { (transaction) in
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
        
        apiClient.readWithURL(GetDetailsMovieRequest(movieId: movieId), URLDecodableType.MovieDetailsEntity) { (transaction) in
            
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
    
    internal func getMovieVideos(movieId: Int, completion: @escaping (Transaction<[VideosEntity]>) -> Void) {
        
        apiClient.readWithURL(GetVideosRequest(movieId: movieId), URLDecodableType.VideosResponseEntity) { (transaction) in
            
            switch transaction {
                
            case .sucess(let data):
                if let dataUnwrapped = data as? [VideosEntity] {
                    completion(Transaction.sucess(dataUnwrapped))
                } else {
                    completion(Transaction.fail(TransactionError.expectedVideosEntity))
                }
            case .fail(let error):
                completion(Transaction.fail(error))
            }
            
        }
    }
        
    
    
    
    
    }
    
    

