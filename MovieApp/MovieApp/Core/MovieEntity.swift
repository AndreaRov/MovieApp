//
//  MovieEntity.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation


struct MovieEntity {
    var name:String?
    var date:String?
    var description:String?
    
    mutating func setMovieName(name:String) {
        self.name = name
    }
    
    mutating func setMovieDate(date:String) {
        self.date = date
    }
    
    mutating func setMovieDescription(description:String) {
        self.description = description
    }
    
    
    func getMovieName() -> String {
        return self.name ?? ""
    }
    
    func getMovieDate() -> String {
        return self.date ?? ""
    }
    
    func getMovieDescription() -> String {
        return self.description ?? ""
    }
    
}
