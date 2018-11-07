//
//  MoviesListTableViewCell.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak private var movieCover: UIImageView!
    @IBOutlet weak private var movieTitle: UILabel!
    @IBOutlet weak private var movieDate: UILabel!
    @IBOutlet weak private var movieDescription: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setMovieCover(cover: UIImage) {
        self.movieCover.image = cover
    }
    
    func setDownloadedImageCover(URLString: String) {
        self.movieCover.imageFromServerURL(URLString, imagePlaceHolder: UIImage(named: "DefaultMoviesListPhoto"))
    }
    
    func setMovieTitle(title: String) {
        self.movieTitle.text = title
    }
    
    func setMovieDate(date: String) {
        self.movieDate.text = date
    }
    
    func setMovieDescription(description: String) {
        self.movieDescription.text = description
    }

    
}
