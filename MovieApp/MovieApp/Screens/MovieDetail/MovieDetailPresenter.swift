//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by andrea on 07/11/2018.
//  Copyright © 2018 andrea. All rights reserved.
//

import Foundation


protocol MovieDetailPresenterDelegate {
    func attachView(view: MovieDetailViewControllerDelegate)
    func detachView()
    func viewIsReady()
    
    func getCoverMovieImageURLString() -> String
    func getBackgroundCoverImageURLString() -> String
    
    func getTicketsWebURL() -> URL?
    func getTrailerURL() -> URL?
}

class MovieDetailPresenter {
    private let movieService:MovieServiceProtocol
    weak private var view: MovieDetailViewControllerDelegate?
    
    internal var movie: PopularMovieEntity
    private var movieDetail: MovieDetailsEntity?
    private var movieVideos = [VideosEntity]()
    
    private var movieVideoTrailerKey = ""
    
    init(movieService: MovieService, movie: PopularMovieEntity) {
        self.movieService = movieService
        self.movie = movie
    }
    
    private func setPopularMovieData() {
        //Cover image
        let urlStringCover = getCoverMovieImageURLString()
        self.view?.setDownloadedImageCover(URLString: urlStringCover)
        //Movie Title
        self.view?.setMovieTitleLabel(title: self.movie.title ?? "")
        //Movie Description
        self.view?.setMovieDescriptionLabel(description: self.movie.overview ?? "")
        //Movie Year from Date
        let date = self.movie.release_date
        let arrDate = date?.components(separatedBy: "-")
        if let year = arrDate?[0] {
            self.view?.setMovieDateLabel(date: "(\(year))")
        } else {
            self.view?.setMovieDateLabel(date: "")
        }
        //Background Cover
        let urlStringBackgroundCover = getBackgroundCoverImageURLString()
        self.view?.setDownloadedImageBackgroundCover(URLString: urlStringBackgroundCover)
    }
    
    private func getMovieDetailFinalGenreString() -> String {
        var finalGenreString = ""
        if let arrGenres = self.movieDetail?.genres{
            var index = 0
            for genre in arrGenres {
                if (arrGenres.count - 1) != index {
                    finalGenreString = finalGenreString + "\(genre.name), "
                } else {
                    finalGenreString = finalGenreString + "\(genre.name)."
                }
                index = index + 1
            }
        }

        if finalGenreString.isEmpty {
            self.view?.setMovieGeneresTitleLabel(title: "")
        }
        return finalGenreString
    }
    
    private func getMovieDetailVoteAverageString() -> String {
        var voteFinalString = ""
        if var voteDoubUnwrapped = self.movieDetail?.vote_average {
            voteDoubUnwrapped = voteDoubUnwrapped * 10
            let voteInteg = Int(voteDoubUnwrapped)
            voteFinalString = String(voteInteg)
            voteFinalString = "\(voteFinalString)%"
        }
        
        if voteFinalString.isEmpty {
            self.view?.setMovieVoteTitleLabel(title: "")
        }
        
        return voteFinalString
    }
    
    private func getVideoTrailerKey() -> String {
        let videos = self.movieVideos
        var videoKey = ""
        for video in videos {
            if video.type == "Trailer" {
                if let videoKeyUnwrapped = video.key {
                    videoKey = videoKeyUnwrapped
                }
            }
        }
        return videoKey
    }
    
    
}


extension MovieDetailPresenter: MovieDetailPresenterDelegate {

    func attachView(view: MovieDetailViewControllerDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    func viewIsReady() {
        //Data taken from the previous presenter
        setPopularMovieData()
        if let movieIdUnwrapped = self.movie.id {
            //Data from movie details
            movieService.getMovieDetails(movieId: movieIdUnwrapped) { (response) in
                switch response {
                case .sucess(let data):
                    self.movieDetail = data
                    
                    DispatchQueue.main.async {
                        if (self.movieDetail?.homepage) == nil {
                            self.view?.setMovieTicketsButtonHidden(hidden: true)
                        }
                        
                        let finalGenreString = self.getMovieDetailFinalGenreString()
                        self.view?.setMovieGenresLabel(genres: finalGenreString)
                        
                        let voteAverageString = self.getMovieDetailVoteAverageString()
                        self.view?.setMovieVoteLabel(voteLavel: voteAverageString)
                        
                        
                    }
                    
                case .fail(let error):
                    print(error)
                }
            }
            
            //Data from movie videos
            /*
            movieService.getMovieVideos(movieId: movieIdUnwrapped) { (response) in
                switch response {
                case .sucess(let data):
                    self.movieVideos = data
                    
                    DispatchQueue.main.async {
                        let trailerKey = self.getVideoTrailerKey()
                        self.movieVideoTrailerKey = trailerKey
                    }
                    
                case .fail(let error):
                    print(error)
                }
            }
            */
            
        }
        
    }
    
    
    func getCoverMovieImageURLString() -> String {
        if let posterPath = self.movie.poster_path {
            let downloadImageRequest = DownloadImageRequest(posterPath: posterPath)
            return downloadImageRequest.resourceName
        }
        return ""
    }
    
    func getBackgroundCoverImageURLString() -> String {
        if let posterPath = self.movie.backdrop_path {
            let downloadImageRequest = DownloadImageRequest(posterPath: posterPath)
            return downloadImageRequest.resourceName
        }
        return ""
    }
    
    
    func getTicketsWebURL() -> URL? {
        
        if let homePageTicketsUnwrapped = self.movieDetail?.homepage, let urlUnwrapped = URL(string: homePageTicketsUnwrapped) {
            return urlUnwrapped
        }
        return nil
    }
    
    func getTrailerURL() -> URL? {
        
        let youtubeBaseURL = "https://www.youtube.com/watch?v="
        let endPoint = self.movieVideoTrailerKey
        let completeURLString = youtubeBaseURL + endPoint
        let trailerURL = URL(string: completeURLString)

        return trailerURL
    }
    
}
