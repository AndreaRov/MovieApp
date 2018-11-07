//
//  PopularMoviesEntity.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

struct PopularMoviesResponseEntity: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [PopularMovieEntity]
}
