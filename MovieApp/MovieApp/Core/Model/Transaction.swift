//
//  Transaction.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation


enum TransactionError: Error {
    case server(message: String)
    case entityUnwrappedFails
    case urlRequestUnwrappedFails
    case expectedPopularMovieEntity
    case expectedMovieDetailsEntity
    case expectedVideosEntity
}

enum Transaction<Value:Any> {
    case sucess(Value)
    case fail(Error)
}


