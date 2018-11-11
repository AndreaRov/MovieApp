//
//  MoviesListTableViewController.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import UIKit

protocol MoviesListTableViewControllerDelegate: class {
    func reloadData()
    func goToDetailView(withIdentifier: String)
    func changeTitle(title: String)
}

class MoviesListTableViewController: UITableViewController {
    
    // MARK: Initialization
    @IBOutlet private var moviesTableView: UITableView!
    @IBOutlet weak var favoritesMoviesBarButtonItem: UIBarButtonItem!
    
    private let presenter:MoviesListPresenterDelegate = MoviesListPresenter(movieService: MovieService(apiClient: TheMovieDataBaseAPIClient()))
    
    // MARK: View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadFavoritesMoviesIfShown()
    }
    
    // MARK: Private Class Methods
    private func configureView() {
        self.presenter.attachView(view: self)
        self.title = "Popular Movies"
        addFavoritesMoviesBarButtonItem()
    }
    
    private func addFavoritesMoviesBarButtonItem() {
        //Favorites Movies Button
        let buttonFavorites: UIButton = UIButton(type: UIButton.ButtonType.custom)
        buttonFavorites.setImage(UIImage(named: "FavoriteTop"), for: UIControl.State.normal)
        buttonFavorites.addTarget(self, action: #selector(favoriteMoviesButtonPressed), for: UIControl.Event.touchUpInside)
        let barButtonFavorites = UIBarButtonItem(customView: buttonFavorites)
        self.navigationItem.rightBarButtonItem = barButtonFavorites
    }
    
    private func addPopularMoviesBarButtonItem() {
        //Popular Movies Button
        let buttonPopular: UIButton = UIButton(type: UIButton.ButtonType.custom)
        buttonPopular.setImage(UIImage(named: "Movies"), for: UIControl.State.normal)
        buttonPopular.addTarget(self, action: #selector(popularMoviesButtonPressed), for: UIControl.Event.touchUpInside)
        let barButtonPopular = UIBarButtonItem(customView: buttonPopular)
        self.navigationItem.rightBarButtonItem = barButtonPopular
    }
    
    private func reloadFavoritesMoviesIfShown() {
        if self.title == "My Favorites Movies" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            self.presenter.showMyFavoritesMovies(managedContext: managedContext)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if presenter.getNumberOfPopularMovies() == 0 {
            //            setBackgroundImage()
            return 0
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfPopularMovies()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellUnwrapped = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviesListTableViewCell {
            cellUnwrapped.setMovieTitle(title: presenter.getCellMovieTitle(indexPath: indexPath))
            cellUnwrapped.setMovieDate(date: presenter.getCellMovieDate(indexPath: indexPath))
            cellUnwrapped.setMovieDescription(description: presenter.getCellMovieDescription(indexPath: indexPath))
            let urlString = presenter.getCoverMovieImageURLString(indexPath: indexPath)
            cellUnwrapped.setDownloadedImageCover(URLString: urlString)
            
            let existNextPage = self.presenter.existPopularMoviesNextPage()
            if existNextPage == true, indexPath.row == self.presenter.getNumberOfPopularMovies() / 2 {
                self.presenter.searchPopularMoviesNextPage()
            }
            
            return cellUnwrapped
        }
        return tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.tableRowSelected(atRow: indexPath.row)
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? MovieDetailViewController {
            presenter.prepareMovieDetailVC(movieDetailViewController: movieDetailViewController)
        }
    }
    
    
    // MARK: - Events
    
    @objc func favoriteMoviesButtonPressed() {
        self.addPopularMoviesBarButtonItem()
        //Recargar tabla con peliculas favoritas
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        self.presenter.showMyFavoritesMovies(managedContext: managedContext)
    }
    
    @objc func popularMoviesButtonPressed() {
        self.addFavoritesMoviesBarButtonItem()
        //Recargar tabla con peliculas populares descargar otra vez del servicio o array
        self.presenter.showPopularMovies()
    }
    
    
}

extension MoviesListTableViewController: MoviesListTableViewControllerDelegate {
    
    func reloadData() {
        self.moviesTableView.reloadData()
    }
    
    func goToDetailView(withIdentifier: String) {
        self.performSegue(withIdentifier: "MoviesListToDetail", sender: self)
    }
    
    func changeTitle(title: String) {
        self.title = title
    }
    
}
