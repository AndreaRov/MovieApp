//
//  APIConstant.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

class APIConstant {
    private static let apiKey = "api_key=fd2e82593bf6824ff553a4937f974165"
    private static let language = "language=en-US"
    private static let movieId = "335983"
    static let popularMoviesEndPoint = "https://api.themoviedb.org/3/movie/popular?\(apiKey)&\(language)"
    static let movieEndPoint = "https://api.themoviedb.org/3/movie/\(movieId)?\(apiKey)&\(language)"
}
