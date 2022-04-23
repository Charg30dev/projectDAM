//
//  Series.swift
//  BingeSeriesApp
//
//  Created by carlos.gonzalezc.local on 5/4/22.
//

import Foundation

struct Series: Codable{
    
    let listOfSeries: [Serie]
    
    enum CodingKeys: String, CodingKey {
        case listOfSeries = "results"
        
    }
}

struct Serie: Codable{
    
        let title: String
        let popularity: Double
        let serieID: Int
        let voteAverage: Double
        let sinopsis: String
        let releaseDate: String
        let image: String
        
        enum CodingKeys: String, CodingKey{
            case title = "name"
            case popularity
            case serieID = "id"
            case voteAverage = "vote_average"
            case sinopsis = "overview"
            case releaseDate = "first_air_date"
            case image = "poster_path"
        }
}
