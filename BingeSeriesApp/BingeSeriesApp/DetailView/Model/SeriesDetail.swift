//
//  SeriesDetail.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation

struct SeriesDetail: Codable {
    let title: String
    let popularity: Double
    let voteAverage: Double
    let sinopsis: String
    let releaseDate: String
    let imageSerie: String
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case popularity
        case voteAverage = "vote_average"
        case sinopsis = "overview"
        case releaseDate = "first_air_date"
        case imageSerie = "poster_path"
    }
}
