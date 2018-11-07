//
//  PopularMovieEntity.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

struct PopularMovieEntity: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
}
