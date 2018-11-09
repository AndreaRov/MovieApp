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
    
    init(id: Int?, title: String?, poster_path: String?, backdrop_path: String?, overview: String?, release_date: String?) {
        self.id = id
        self.title = title
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.overview = overview
        self.release_date = release_date
    }
    
}
