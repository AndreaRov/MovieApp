//
//  MoviesListPresenter.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation
import CoreData


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
    func showMyFavoritesMovies(managedContext: NSManagedObjectContext)
    func showPopularMovies()
}


class MoviesListPresenter {
    
    private let movieService:MovieService
    weak private var view: MoviesListTableViewControllerDelegate?
    
    internal var arrMovies = [PopularMovieEntity]()
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
                self.arrMovies = data
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            case .fail(let error):
                print(error)
            }
        })
    }
    
    func getNumberOfPopularMovies() -> Int {
        return self.arrMovies.count
    }
    
    func getCellMovieTitle(indexPath: IndexPath) -> String {
        return self.arrMovies[indexPath.row].title ?? ""
    }
    
    func getCellMovieDate(indexPath: IndexPath) -> String {
        return self.arrMovies[indexPath.row].release_date ?? ""
    }
    
    func getCellMovieDescription(indexPath: IndexPath) -> String {
        return self.arrMovies[indexPath.row].overview ?? ""
    }
    
    func getCoverMovieImageURLString(indexPath: IndexPath) -> String {
        if let posterPath = self.arrMovies[indexPath.row].poster_path {
            let downloadImageRequest = DownloadImageRequest(posterPath: posterPath)
            return downloadImageRequest.resourceName
        }
        return ""
    }
    
    func tableRowSelected(atRow: Int) {
        self.movieEntitySelected = self.arrMovies[atRow]
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
    
    func showMyFavoritesMovies(managedContext: NSManagedObjectContext) {
         //Load favorites movies from Core Data
        var tasks = [NSManagedObject]()
        let fetchRequest : NSFetchRequest<FavoritesMovies> = FavoritesMovies.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            tasks = results as [NSManagedObject]
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
        
        //Read the favorites movies from core data and save in array
        self.arrMovies.removeAll()
        for task in tasks {
            let id = task.value(forKey: "id") as? Int
            let title = task.value(forKey: "title") as? String
            let poster_path = task.value(forKey: "poster_path") as? String
            let backdrop_path = task.value(forKey: "backdrop_path") as? String
            let overview = task.value(forKey: "overview") as? String
            let release_date = task.value(forKey: "release_date") as? String
            
            let favoriteMovie = PopularMovieEntity(id: id, title: title, poster_path: poster_path, backdrop_path: backdrop_path, overview: overview, release_date: release_date)
            self.arrMovies.append(favoriteMovie)
        }
        
        // Reload table with favorite movies
        self.view?.changeTitle(title: "My Favorites Movies")
        self.view?.reloadData()
   
    }
    
    func showPopularMovies() {
        movieService.getCurrentPopularMovies(completion: { (response) in
            switch response {
            case .sucess(let data):
                self.arrMovies = data
                DispatchQueue.main.async {
                    self.view?.changeTitle(title: "Popular Movies")
                    self.view?.reloadData()
                }
            case .fail(let error):
                print(error)
            }
        })
    }
    
}
