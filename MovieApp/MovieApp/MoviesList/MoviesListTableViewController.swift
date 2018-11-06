//
//  MoviesListTableViewController.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController {
    
    @IBOutlet var moviesTableView: UITableView!
    
    var arrMovie = [MovieEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getPopularMoviesData()
        self.moviesTableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if getNumberOfPopularMovies() == 0 {
//            setBackgroundImage()
            return 0
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfPopularMovies()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellUnwrapped = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MoviesListTableViewCell {
            // Configure the cell...
            let movieData = getCellData(cellForRowAt: indexPath)
            
            cellUnwrapped.setMovieTitle(title: movieData.getMovieName())
            cellUnwrapped.setMovieDate(date: movieData.getMovieDate())
            cellUnwrapped.setMovieDescription(description: movieData.getMovieDescription())
            
            return cellUnwrapped
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    private func getPopularMoviesData() {
        self.arrMovie = mockInfo()
    }
    
    private func getNumberOfPopularMovies() -> Int {
        return self.arrMovie.count
    }
    
    private func getCellData(cellForRowAt indexPath: IndexPath) -> MovieEntity {
        let name = self.arrMovie[indexPath.row].getMovieName()
        let date = self.arrMovie[indexPath.row].getMovieDate()
        let description = self.arrMovie[indexPath.row].getMovieDescription()
        let movieCell = MovieEntity.init(name: name, date: date, description: description)
        return movieCell
    }
    
    private func setBackgroundImage() {
        
    }

    
    private func mockInfo() -> [MovieEntity] {
        var arr:[MovieEntity]
        let movie1 = MovieEntity.init(name: "Venom", date: "October 5, 2018", description: "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego \"Venom\" to save his life.")
        let movie2 = MovieEntity.init(name: "Bohemian Rhapsody", date: "November 2, 2018", description: "Singer Freddie Mercury, guitarist Brian May, drummer Roger Taylor and bass guitarist John Deacon take the music world by storm when they form the rock 'n' roll band Queen in 1970. Hit songs become instant classics. When Mercury's increasingly wild lifestyle starts to spiral out of control, Queen soon faces its greatest challenge yet – finding a way to keep the band together amid the success and excess.")
        arr = [movie1, movie2]
        return arr
    }
    
}
