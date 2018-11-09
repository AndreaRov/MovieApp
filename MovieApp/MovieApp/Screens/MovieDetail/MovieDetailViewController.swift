//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by andrea on 06/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import UIKit
//import AVKit

protocol MovieDetailViewControllerDelegate: class {
    func setMovieCoverImageView(image: UIImage)
    func setDownloadedImageCover(URLString: String)
    func setMovieTitleLabel(title: String)
    func setMovieDateLabel(date: String)
    func setMovieDescriptionLabel(description: String)
    func setMovieBackgroundCoverImageView(image: UIImage)
    func setDownloadedImageBackgroundCover(URLString: String)
    func setMovieGeneresTitleLabel(title: String)
    func setMovieGenresLabel(genres: String)
    func setMovieVoteTitleLabel(title: String)
    func setMovieVoteLabel(voteLavel: String)
    
    func setMovieTicketsButtonHidden(hidden: Bool)
}

class MovieDetailViewController: UIViewController {
    // MARK: Initialization
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var movieBackgroundCoverImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var markAsFavoriteButton: UIButton!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieGeneresTitleLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieVoteTitleLabel: UILabel!
    @IBOutlet weak var movieVoteLabel: UILabel!
    @IBOutlet weak var movieTicketsButton: UIButton!
    
    
    
    internal var presenter: MovieDetailPresenterDelegate?

    // MARK: View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.presenter?.viewIsReady()
    }
    
    // MARK: Private Class Methods
    
    private func configureView() {
        self.presenter?.attachView(view: self)
        self.trailerButton.isHidden = true
    }
    
    private func setImageMarkAsFavoriteButton() {
        if let favoriteButtonImageUnwrapped = markAsFavoriteButton.imageView?.image {
            if favoriteButtonImageUnwrapped == UIImage(named: "FavoriteFilmOff") {
                self.markAsFavoriteButton.setImage(UIImage(named: "FavoriteFilmOn"), for: UIControl.State.normal)
                self.markAsFavoriteButton.setTitle("Favorite", for: UIControl.State.normal)
                
            } else {
                self.markAsFavoriteButton.setImage(UIImage(named: "FavoriteFilmOff"), for: UIControl.State.normal)
                self.markAsFavoriteButton.setTitle("Mark As Favorite", for: UIControl.State.normal)
            }
        }
    }
    
    
    // MARK: Events
    @IBAction func movieTicketsButtonPressed(_ sender: Any) {
        
        if let urlUnwrapped = self.presenter?.getTicketsWebURL() {
            UIApplication.shared.open(urlUnwrapped, options: [:])
        }
       
    }
    
    @IBAction func trailerButtonPressed(_ sender: Any) {
        
//        if let urlUnwrapped = self.presenter?.getTrailerURL() {
//        if let urlUnwrapped = URL(string: "https://www.youtube.com/watch?v=bhxhNIQBKJI") {
            
            /*
            let player = AVPlayer(url: urlUnwrapped)
            let playerViewController  =  AVPlayerViewController()
            playerViewController.player   =  player
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
             */
//        }
  
    }
    
    
    @IBAction func markAsFavoriteButtonPressed(_ sender: Any) {
        setImageMarkAsFavoriteButton()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        self.presenter?.addAsFavoriteMovie(managedContext: managedContext)
    }
    

}


extension MovieDetailViewController: MovieDetailViewControllerDelegate {
    
    func setMovieCoverImageView(image: UIImage) {
        self.movieCoverImageView.image = image
    }
    
    func setDownloadedImageCover(URLString: String) {
        self.movieCoverImageView.imageFromServerURL(URLString, imagePlaceHolder: nil)
    }
    
    func setMovieTitleLabel(title: String) {
        self.movieTitleLabel.text = title
    }
    
    func setMovieDateLabel(date: String) {
        self.movieDateLabel.text = date
    }
    
    func setMovieDescriptionLabel(description: String) {
        self.movieDescriptionLabel.text = description
    }
    
    func setMovieBackgroundCoverImageView(image: UIImage) {
        self.movieBackgroundCoverImageView.image = image
    }
    
    func setDownloadedImageBackgroundCover(URLString: String) {
        self.movieBackgroundCoverImageView.imageFromServerURL(URLString, imagePlaceHolder: nil)
    }
    
    func setMovieGeneresTitleLabel(title: String) {
        self.movieGeneresTitleLabel.text = title
    }
    
    func setMovieGenresLabel(genres: String) {
        self.movieGenresLabel.text = genres
    }
    
    func setMovieVoteTitleLabel(title: String) {
        self.movieVoteTitleLabel.text = title
    }
    
    func setMovieVoteLabel(voteLavel: String) {
        self.movieVoteLabel.text = voteLavel
    }
    
    func setMovieTicketsButtonHidden(hidden: Bool) {
        self.movieTicketsButton.isHidden = hidden
    }
    
    
  
    
}
