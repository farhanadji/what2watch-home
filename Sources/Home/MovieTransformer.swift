//
//  MovieTransformer.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Core

public struct MovieTransformer: Mapper {
    public init() {} 
    public typealias Response = [MovieResponse]
    
    public typealias Request = Any
    
    public typealias Entity = Any
    
    public typealias Domain = [Movie]
    
    public func transformResponsesToDomains(response: [MovieResponse]) -> [Movie] {
        return response.map { result in
            return Movie(
                id: result.id ?? 0,
                backdropPath: result.backdropPath ?? "",
                title: result.title ?? "-",
                posterPath: result.posterPath ?? "-",
                releaseDate: result.releaseDate ?? "-")
        }
    }
    
    public func transformEntitiesToDomains(entity: Any) -> [Movie] {
        fatalError("No need!")
    }
    
    public func transformDomainToEntity(domain: [Movie]) -> Any {
        fatalError()
    }
}
