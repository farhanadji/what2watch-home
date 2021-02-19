//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Core
import Foundation
import Combine
import Alamofire

public struct HomeRemoteDataSource: DataSource {

    public typealias Request = Endpoints.Gets
    
    public typealias Response = [MovieResponse]
    
    public func execute(request: Endpoints.Gets?) -> AnyPublisher<[MovieResponse], Error> {
        return Future<[MovieResponse], Error> { completion in
            if let url = URL(string: request?.url ?? "") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MoviesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.movieList))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
            
        }
        .eraseToAnyPublisher()
    }
    
}


