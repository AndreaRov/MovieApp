//
//  MovieService.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    func getPopularMovies(completion: @escaping (Transaction<[PopularMovieEntity]>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    let apiClient: TheMovieDataBaseAPIClientProtocol
    
    init(apiClient: TheMovieDataBaseAPIClient) {
        self.apiClient = apiClient
    }
    
    
    func getPopularMovies(completion: @escaping (Transaction<[PopularMovieEntity]>) -> Void) {
        
        apiClient.read(GetPopularMoviesRequest(), DecodableType.PopularMoviesResponseEntity) { (transaction) in
            switch transaction {
                
            case .sucess(let data):
                if let dataUnwrapped = data as? [PopularMovieEntity] {
                    completion(Transaction.sucess(dataUnwrapped))
                }
                completion(Transaction.fail(TransactionError.expectedPopularMovieEntity))
            case .fail(let error):
                completion(Transaction.fail(error))
            }
        }
    }
    
    
    
}
