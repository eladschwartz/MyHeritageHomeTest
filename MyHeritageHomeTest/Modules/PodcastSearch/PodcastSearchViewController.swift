//
//  PodcastSearchViewController.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import UIKit
import Combine

class PodcastSearchViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    private var viewModel            : PodcastSearchViewModelProtocol = PodcastSearchViewModel()
    private var tableViewController  : SearchTableControllerProtocol!
    private var cancellables     = Set<AnyCancellable>()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupUISearchController()
        handlePodcasts()
        listenForSearchTextChanges()
        setupInitialData()
    }
    
    private func handlePodcasts(){
        viewModel.podcastsPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] podcasts in
                guard let self = self else { return }
                
                self.tableViewController.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupInitialData(){
        viewModel.search(for: "ios")
    }
    
    private func setupUI(){
        tableViewController = SearchTableController(tableView: tableView, viewModel: viewModel, delegate: self)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUISearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder                = "Search Podcasts"
        navigationItem.searchController                       = searchController
    }
    
    private func listenForSearchTextChanges(){
        let publisher = NotificationCenter.default.publisher(for    : UISearchTextField.textDidChangeNotification,
                                                             object : searchController.searchBar.searchTextField)
        publisher.compactMap{
            ($0.object as? UISearchTextField)?.text
        }
        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
        .sink { [weak self] (text) in
            guard let self = self else { return }
            self.viewModel.search(for: text)
        }
        .store(in: &cancellables)
    }
}

extension PodcastSearchViewController : SearchTableControllerDelegate {
    
    func didSelectPodcast(podcast: Podcast) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let detailsViewController = storyboard.instantiateViewController(
                  identifier: "PodcastDetailsViewController",
                  creator: { coder in
                      let viewModel = PodcastDetailsViewModel(artistName     : podcast.artistName,
                                                              trackName      : podcast.trackName,
                                                              releaseDate    : podcast.releaseDate,
                                                              imageUrlString : podcast.artworkUrl100)
                      
                      return PodcastDetailsViewController(viewModel: viewModel, coder: coder)
                  }
              )
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
