//
//  MoviesListPresenter.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation


protocol MoviesListPresenterDelegate {
    func attachView(view: MoviesListTableViewControllerDelegate)
    func detachView()
    func viewIsReady()
    func getNumberOfPopularMovies() -> Int
    func getCellMovieTitle(indexPath: IndexPath) -> String
    func getCellMovieDate(indexPath: IndexPath) -> String
    func getCellMovieDescription(indexPath: IndexPath) -> String
}


class MoviesListPresenter {
    
    private let movieService:MovieService
    weak private var view: MoviesListTableViewControllerDelegate?
    
    var arrMovie = [MovieEntity]()
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    
}

extension MoviesListPresenter: MoviesListPresenterDelegate {
    
    func attachView(view: MoviesListTableViewControllerDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func viewIsReady() {
        movieService.getPopularMovies(onCompletion: { (response) in
            switch response {
            case .sucess(let data):
                self.arrMovie = data
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            case .fail(let error):
                print(error)
            }
        })
    }
    
    func getNumberOfPopularMovies() -> Int {
        return self.arrMovie.count
    }
    
    func getCellMovieTitle(indexPath: IndexPath) -> String {
        return self.arrMovie[indexPath.row].getMovieName()
    }
    
    func getCellMovieDate(indexPath: IndexPath) -> String {
        return self.arrMovie[indexPath.row].getMovieDate()
    }
    
    func getCellMovieDescription(indexPath: IndexPath) -> String {
        return self.arrMovie[indexPath.row].getMovieDescription()
    }

    
    
}
