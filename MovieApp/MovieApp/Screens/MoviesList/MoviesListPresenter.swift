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
    func getCoverMovieImageURLString(indexPath: IndexPath) -> String
    func tableRowSelected(atRow: Int)
    func prepareMovieDetailVC(movieDetailViewController: MovieDetailViewController)
}


class MoviesListPresenter {
    
    private let movieService:MovieService
    weak private var view: MoviesListTableViewControllerDelegate?
    
    internal var arrMovie = [PopularMovieEntity]()
    internal var movieEntitySelected: PopularMovieEntity?
    
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
        movieService.getCurrentPopularMovies(completion: { (response) in
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
        return self.arrMovie[indexPath.row].title ?? ""
    }
    
    func getCellMovieDate(indexPath: IndexPath) -> String {
        return self.arrMovie[indexPath.row].release_date ?? ""
    }
    
    func getCellMovieDescription(indexPath: IndexPath) -> String {
        return self.arrMovie[indexPath.row].overview ?? ""
    }
    
    func getCoverMovieImageURLString(indexPath: IndexPath) -> String {
        if let posterPath = self.arrMovie[indexPath.row].poster_path {
            let downloadImageRequest = DownloadImageRequest(posterPath: posterPath)
            return downloadImageRequest.resourceName
        }
        return ""
    }
    
    func tableRowSelected(atRow: Int) {
        self.movieEntitySelected = self.arrMovie[atRow]
        self.view?.goToDetailView(withIdentifier: "MoviesListToDetail")
    }
    
    func prepareMovieDetailVC(movieDetailViewController: MovieDetailViewController) {
        //Initialize API
        let theMovieDataBaseAPIClient = TheMovieDataBaseAPIClient()
        //Initialize Service
        let movieService = MovieService(apiClient: theMovieDataBaseAPIClient)
        if let movieEntitySelectedUnwrapped = self.movieEntitySelected {
            //Initialize presenter
            movieDetailViewController.presenter = MovieDetailPresenter(movieService: movieService, movie: movieEntitySelectedUnwrapped)
        }
        
    }
    
}
