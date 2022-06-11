//
//  PodcastSearchViewModel.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation
import Combine

protocol PodcastSearchViewModelProtocol {
    var podcastsPublisher: Published<[Podcast]>.Publisher { get }
    
    func getPodcastData(for searchText: String) async
    func search(for searchText: String)
    
    var podcasts : [Podcast] { get }
}

class PodcastSearchViewModel : PodcastSearchViewModelProtocol {
    private let requestManager : RequestManagerProtocol
    private var cancellables   = Set<AnyCancellable>()
    
    @Published var podcasts : [Podcast] = []
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    var podcastsPublisher: Published<[Podcast]>.Publisher { $podcasts}
    
    func getPodcastData(for searchText: String) async {
        guard !searchText.isEmpty else { return }
        do
        {
            let request = iTunesSearchRequest.search(searchText: searchText)
            let data : RootResults = try await requestManager.perform(request)
            podcasts = data.results
        }
        catch(let error){
            print(error)
        }
    }
    
    func search(for searchText: String) {
        Task
        {
            await getPodcastData(for: searchText)
        }
    }
}
