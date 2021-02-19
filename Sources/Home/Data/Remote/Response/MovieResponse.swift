//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Foundation
import Core

public struct MoviesResponse: Decodable {
    let movieList: [MovieResponse]
    
    private enum CodingKeys: String, CodingKey {
        case movieList = "results"
    }
}

public struct MovieResponse: Decodable {
    let id: Int?
    let backdropPath: String?
    let title: String?
    let posterPath: String?
    let releaseDate: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let posterPath = try container.decode(String?.self, forKey: .posterPath)
        self.posterPath = "\(API.imageUrl)\(posterPath ?? "")"
        let backdropPath = try container.decode(String?.self, forKey: .backdropPath)
        self.backdropPath = "\(API.imageUrl)\(backdropPath ?? "")"
        title = try container.decode(String?.self, forKey: .title)
        id = try container.decode(Int?.self, forKey: .id)
        
        let date = try container.decode(String?.self, forKey: .releaseDate)
        if let year = date?.split(separator: "-")[0] {
            self.releaseDate = String(year)
        } else {
            self.releaseDate = "-"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
