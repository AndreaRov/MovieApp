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
}

class MoviesListTableViewController: UITableViewController {
    
    // MARK: Initialization
    @IBOutlet private var moviesTableView: UITableView!
    private let presenter:MoviesListPresenterDelegate = MoviesListPresenter(movieService: MovieService(apiClient: TheMovieDataBaseAPIClient()))
    
    // MARK: View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewIsReady()
    }
    
    // MARK: Private Class Methods
    
    private func configureView() {
        self.presenter.attachView(view: self)
        self.title = "Popular Movies"
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
            return cellUnwrapped
        }
        return tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.tableRowSelected(atRow: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailViewController = segue.destination as? MovieDetailViewController {
            presenter.prepareMovieDetailVC(movieDetailViewController: movieDetailViewController)
        }
    }
    
    
    
}

extension MoviesListTableViewController: MoviesListTableViewControllerDelegate {
    
    func reloadData() {
        self.moviesTableView.reloadData()
    }
    
    func goToDetailView(withIdentifier: String) {
        self.performSegue(withIdentifier: "MoviesListToDetail", sender: self)
    }
    
}
