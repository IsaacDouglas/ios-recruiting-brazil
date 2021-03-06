//
//  Popular.swift
//  movs
//
//  Created by Isaac Douglas on 23/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit
import CEPCombine

struct Popular: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

class Movie: Codable {
    
    var popularity: Double = 0.0
    var voteCount: Int = 0
    var video: Bool = false
    var posterPath: String = ""
    var id: Int = 0
    var adult: Bool = false
    var backdropPath: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var genreIDS = [Int]()
    var title: String = ""
    var voteAverage: Double = 0.0
    var overview: String = ""
    var releaseDate: String = ""
    
    private var _image: UIImage?
    var image: UIImage? {
        get {
            guard let image = _image else {
                self.downloadImage()
                return nil
            }
            return image
        }
        set {
            self._image = newValue
        }
    }
    
    required init() { }

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    private func downloadImage() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342" + self.posterPath) else { return }
        URLSession.shared.imageTask(with: url) { image, response, error in
            if let image = image {
                self._image = image
                let event = MovieImageDownloadEvent(data: self)
                CBEventManager.addEvent(event: event)
            }
        }.resume()
    }
}
