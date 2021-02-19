//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Combine
import Core

public struct HomeRepository<RemoteDataSource: DataSource, Transformer: Mapper>: Repository where RemoteDataSource.Request == Endpoints.Gets, RemoteDataSource.Response == [MovieResponse], Transformer.Response == [MovieResponse], Transformer.Domain == [Movie], Transformer.Entity == Any, Transformer.Request == Any {
    
    public typealias Request = Endpoints.Gets
    public typealias Response = [Movie]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(remoteDataSource: RemoteDataSource, mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Endpoints.Gets?) -> AnyPublisher<[Movie], Error> {
        return _remoteDataSource.execute(request: request)
            .map {
                _mapper.transformResponsesToDomains(response: $0)
            }
            .eraseToAnyPublisher()
    }
    
    
}
