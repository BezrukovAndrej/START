//
//  Constants.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import Foundation

struct Constants {
    static let identifierTableCell = "CollectionViewTableViewCell"
    static let identifierViewCell = "TitleCollectionViewCell"
    static let identifierUpcomingCell = "TitleTableViewCell"
    
    static let apiKey = "e01d7ca0b2dc17471badb0671c70461c"
    static let baseURL = "https://api.themoviedb.org/"
    static let configureCellImage = "https://image.tmdb.org/t/p/w500/"
    static let trendingMovie = "/3/trending/movie/day?api_key="
    static let trendingTV = "/3/trending/tv/day?api_key="
    static let upcomingMovie = "/3/movie/upcoming?api_key="
    static let moviePopular = "/3/movie/popular?api_key="
    static let movieTop = "/3/movie/top_rated?api_key="
    static let discover = "/3/discover/movie?api_key="
    static let search = "/3/search/movie?api_key="
    
    static let notificationName = "downloded"
    static let trailer = "trailer"
    
    static let youTubeApi = "AIzaSyDgPfJ6vJW2PUdxIrE_JXIrhadFKgPTlz8"
    static let youTubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let youTubeSearchId = "https://www.youtube.com/embed/"
}
