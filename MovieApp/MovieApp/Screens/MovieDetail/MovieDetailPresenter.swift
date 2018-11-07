//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation


protocol MovieDetailPresenterDelegate {
    func attachView(view: MovieDetailViewControllerDelegate)
    func detachView()
    func viewIsReady()
}

class MovieDetailPresenter {
    private let movieService:MovieService
    weak private var view: MovieDetailViewControllerDelegate?
    
    internal var movie: PopularMovieEntity
    
    init(movieService: MovieService, movie: PopularMovieEntity) {
        self.movieService = movieService
        self.movie = movie
    }
    
    
}


extension MovieDetailPresenter: MovieDetailPresenterDelegate {

    func attachView(view: MovieDetailViewControllerDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func viewIsReady() {
        
//        movieService.getPopularMovies(completion: { (response) in
//            switch response {
//            case .sucess(let data):
//                self.arrMovie = data
//                DispatchQueue.main.async {
//                    self.view?.reloadData()
//                }
//            case .fail(let error):
//                print(error)
//            }
//        })
        
        
    }
    
}
