//
//  GetDetailsMovieRequest.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

class GetDetailsMovieRequest: APIRequest {
    typealias Response = [PopularMovieEntity]
    
    var resourceName: String {
        let apiKey = "api_key=fd2e82593bf6824ff553a4937f974165"
        let language = "language=en-US"
        return "https://api.themoviedb.org/3/movie/\(movieId)?\(apiKey)&\(language)"
    }
    
    // Parameters
    private let movieId: Int
    
    public init(movieId: Int) {
        self.movieId = movieId
    }
}
