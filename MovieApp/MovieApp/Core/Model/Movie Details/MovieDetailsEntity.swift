//
//  MovieDetailsEntity.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

struct MovieDetailsEntity: Codable {
    let homepage: String? 
    let genres: [GenresEntity]
    let vote_average:Double?
}
