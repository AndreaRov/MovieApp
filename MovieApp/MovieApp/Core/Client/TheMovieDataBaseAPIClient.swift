//
//  TheMovieDBAPI.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol TheMovieDataBaseAPIClientProtocol {
    func readWithURL<T: APIRequest>(_ request: T, _ decodable: URLDecodableType, completion: @escaping (Transaction<Any>) -> Void)
}

enum URLDecodableType {
    case PopularMoviesResponseEntity
    case MovieDetailsEntity
    case VideosResponseEntity
}

class TheMovieDataBaseAPIClient: TheMovieDataBaseAPIClientProtocol {
    
    internal func readWithURL<T: APIRequest>(_ request: T, _ decodable: URLDecodableType, completion: @escaping (Transaction<Any>) -> Void) {
        let jsonDec = JSONDecoder()
        if let baseUrlUnwrapped = URL(string: request.resourceName) {
            URLSession.shared.dataTask(with: baseUrlUnwrapped) { (data, response, error) in
                if error != nil{
                    completion(Transaction.fail(TransactionError.server(message: error.debugDescription)))
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 401 || httpResponse.statusCode == 404 {
                        let statusMessage = try? jsonDec.decode(HTTPStatusCode.self, from: data!)
                        print("Status code: \(httpResponse.statusCode).", statusMessage?.status_message ?? "")
                        completion(Transaction.fail(TransactionError.server(message: statusMessage?.status_message ?? "Status code: \(httpResponse.statusCode)")))
                        
                    } else if httpResponse.statusCode == 200 {
                        switch decodable {
                            
                        case .PopularMoviesResponseEntity:
                            let popularMovies = try? jsonDec.decode(PopularMoviesResponseEntity.self, from: data!)
//                            print("TotalMovies:",popularMovies?.results.count as Any)
                            
                            if let movieEntityUnwrapped = popularMovies?.results {
                                completion(Transaction.sucess(movieEntityUnwrapped))
                            } else {
                                completion(Transaction.fail(TransactionError.entityUnwrappedFails))
                            }
                            
                        case .MovieDetailsEntity:
                            let detailsMovies = try? jsonDec.decode(MovieDetailsEntity.self, from: data!)
                            
                            if let detailsMoviesUnwrapped = detailsMovies {
                                completion(Transaction.sucess(detailsMoviesUnwrapped))
                            } else {
                                completion(Transaction.fail(TransactionError.entityUnwrappedFails))
                            }
                            
                            case .VideosResponseEntity:
                            let movieVideos = try? jsonDec.decode(VideosResponseEntity.self, from: data!)
                            
                            if let movieVideosUnwrapped = movieVideos?.results {
                                completion(Transaction.sucess(movieVideosUnwrapped))
                            } else {
                                completion(Transaction.fail(TransactionError.entityUnwrappedFails))
                            }
                            
                            
                            
                        }
    
                    }
                }
                }.resume()
            
        } else {
            completion(Transaction.fail(TransactionError.urlRequestUnwrappedFails))
        }
    }
    
    
    
    
    
}
