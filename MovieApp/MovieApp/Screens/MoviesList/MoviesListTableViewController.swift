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
            return cellUnwrapped
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
    }
    
}

extension MoviesListTableViewController: MoviesListTableViewControllerDelegate {
    
    func reloadData() {
        self.moviesTableView.reloadData()
    }
    

}
