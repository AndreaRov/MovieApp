//
//  DownloadImageRequest.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation

//This class not comform to protocol becase we will use it in UIImageExtension
class DownloadImageRequest {
    
    private let posterPath: String
    
    public init(posterPath: String) {
        self.posterPath = posterPath
    }
    
    var resourceName: String {
        //Emample image: https://image.tmdb.org/t/p/w1280/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg
        //Request back: /2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg
        return "https://image.tmdb.org/t/p/w1280" + posterPath
    }
    
    

}
