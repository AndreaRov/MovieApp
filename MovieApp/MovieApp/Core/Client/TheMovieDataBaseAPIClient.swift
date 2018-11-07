//
//  TheMovieDBAPI.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol TheMovieDataBaseAPIClientProtocol {
    func read<T: APIRequest>(_ request: T, _ decodable: DecodableType, completion: @escaping (Transaction<[Any]>) -> Void)
}

enum DecodableType {
    case PopularMoviesResponseEntity
}

class TheMovieDataBaseAPIClient: TheMovieDataBaseAPIClientProtocol {
    
    internal func read<T: APIRequest>(_ request: T, _ decodable: DecodableType, completion: @escaping (Transaction<[Any]>) -> Void) {
        let jsonDec = JSONDecoder()
        if let baseUrlUnwrapped = URL(string: request.resourceName) {
            URLSession.shared.dataTask(with: baseUrlUnwrapped) { (data, response, error) in
                if error != nil{
                    print("Error \(String(describing: error))")
                    completion(Transaction.fail(TransactionError.server(message: error.debugDescription)))
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 401 || httpResponse.statusCode == 404 {
                        let statusMessage = try? jsonDec.decode(HTTPStatusCode.self, from: data!)
                        print("Status code: \(httpResponse.statusCode).", statusMessage?.status_message ?? "")
                        completion(Transaction.fail(TransactionError.server(message: statusMessage?.status_message ?? "Status code: \(httpResponse.statusCode)")))
                        
                    } else if httpResponse.statusCode == 200 {
                        //TODO: Si hay distintas request, cambiará el Decodable.Protocol
                        switch decodable {
                        case .PopularMoviesResponseEntity:
                            let popularMovies = try? jsonDec.decode(PopularMoviesResponseEntity.self, from: data!)
                            //TODO: Delete this print
                            print("TotalMovies:",popularMovies?.results.count as Any)
                            
                            if let movieEntityUnwrapped = popularMovies?.results {
                                completion(Transaction.sucess(movieEntityUnwrapped))
                            } else {
                                completion(Transaction.fail(TransactionError.entityUnwrappedFails))
                            }
                            
                        }
                      
                        
                    }
                    
                }
                }.resume()
            
        }
        completion(Transaction.fail(TransactionError.urlRequestUnwrappedFails))
    }
    
    
    
    
    
    
//
//    static func getPopularMovies(onCompletion: @escaping (Transaction<[PopularMovieEntity]>) -> Void) {
//        let jsonDec = JSONDecoder()
//        if let urlRequestUnwrapped = APIConstant.popularMoviesEndPointURL {
//
//            URLSession.shared.dataTask(with: urlRequestUnwrapped) { (data, response, error) in
//                if error != nil{
//                    print("Error \(String(describing: error))")
//                    onCompletion(Transaction.fail(TransactionError.server(message: error.debugDescription)))
//                }
//
//                if let httpResponse = response as? HTTPURLResponse {
//
//                    if httpResponse.statusCode == 401 || httpResponse.statusCode == 404 {
//                        let statusMessage = try? jsonDec.decode(HTTPStatusCode.self, from: data!)
//                        print("Status code: \(httpResponse.statusCode).", statusMessage?.status_message ?? "")
//                        onCompletion(Transaction.fail(TransactionError.server(message: statusMessage?.status_message ?? "Status code: \(httpResponse.statusCode)")))
//
//                    } else if httpResponse.statusCode == 200 {
//                        let popularMovies = try? jsonDec.decode(PopularMoviesResponseEntity.self, from: data!)
//                        print("TotalMovies:",popularMovies?.results.count as Any)
//
//                        if let movieEntityUnwrapped = popularMovies?.results {
//                            onCompletion(Transaction.sucess(movieEntityUnwrapped))
//                        } else {
//                            onCompletion(Transaction.fail(TransactionError.movieEntityUnwrappedFails))
//                        }
//                    }
//
//                }
//                }.resume()
//
//
//        } else {
//            onCompletion(Transaction.fail(TransactionError.urlRequestUnwrappedFails))
//        }
//
//    }
//
//
    
    
    
    
    
}
