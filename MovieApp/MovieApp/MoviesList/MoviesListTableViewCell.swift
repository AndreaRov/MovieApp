//
//  MoviesListTableViewCell.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setMovieCover(cover: UIImage) {
        self.movieCover.image = cover
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
