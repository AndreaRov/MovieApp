//
//  APIRequest.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable
    var resourceName: String { get }
    
    //    static let movieImagesBaseURL = "https://image.tmdb.org/t/p/w1280"
}
