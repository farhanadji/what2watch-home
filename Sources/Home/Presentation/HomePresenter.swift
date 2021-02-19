//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Foundation
import Combine
import Core

public class HomePresenter<HomeUseCase: UseCase>: ObservableObject where HomeUseCase.Request == Endpoints.Gets, HomeUseCase.Response == [Movie] {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _homeUseCase: HomeUseCase
    
    @Published var errorMessage: String = ""
    @Published var popularState: State = .idle
    @Published var featuredState: State = .idle
    @Published var nowPlayingState: State = .idle
    
    @Published var popularMovies: [Movie] = []
    @Published var featuredMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    
    public init(homeUseCase: HomeUseCase) {
        _homeUseCase = homeUseCase
    }
    
    func getPopularMovies() {
        guard popularMovies.count == 0 else {
            popularState = .loaded
            return
        }
        
        popularState = .loading
        _homeUseCase.execute(request: .popular)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.popularState = .loaded
                }
            } receiveValue: { popularMovies in
                self.popularMovies = popularMovies
            }
            .store(in: &cancellables)
    }
    
    func getFeaturedMovies() {
        guard featuredMovies.count == 0 else {
            featuredState = .loaded
            return
        }
        
        featuredState = .loading
        _homeUseCase.execute(request: .featured)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.featuredState = .loaded
                }
            } receiveValue: { featuredMovies in
                self.featuredMovies = featuredMovies
            }
            .store(in: &cancellables)
    }
    
    func getNowPlayingMovies() {
        guard nowPlayingMovies.count == 0 else {
            nowPlayingState = .loaded
            return
        }
        
        nowPlayingState = .loading
        _homeUseCase.execute(request: .nowPlaying)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.nowPlayingState = .loaded
                }
            } receiveValue: { nowPlayingMovies in
                self.nowPlayingMovies = nowPlayingMovies
            }
            .store(in: &cancellables)
    }
}
