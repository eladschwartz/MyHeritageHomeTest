//
//  SearchTableController.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 11/06/2022.
//

import Foundation
import UIKit

protocol SearchTableControllerProtocol : UITableViewDelegate {
    var tableView  : UITableView! { get set }
    
    func reloadData()
}

protocol SearchTableControllerDelegate: AnyObject {
    func didSelectPodcast(podcast: Podcast)
}

class SearchTableController : NSObject, SearchTableControllerProtocol {
    
    enum Section {
        case main
    }
    
    typealias TableDataSource = UITableViewDiffableDataSource<Section, Podcast>
    typealias Snapshot        = NSDiffableDataSourceSnapshot<Section, Podcast>
    
    private lazy var dataSource: TableDataSource =  makeDataSource()
    
    weak var tableView        : UITableView!
    private var viewModel     : PodcastSearchViewModelProtocol = PodcastSearchViewModel()
    private weak var delegate : SearchTableControllerDelegate?
    
    init(tableView  : UITableView,
         viewModel  : PodcastSearchViewModelProtocol,
         delegate   : SearchTableControllerDelegate){
        
        self.tableView = tableView
        self.viewModel = viewModel
        self.delegate  = delegate
        
        super.init()
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.register(UINib(nibName: PodcastSearchCell.identifier, bundle: nil), forCellReuseIdentifier: PodcastSearchCell.identifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private func makeDataSource() -> TableDataSource {
        let dataSource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, podcast) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  PodcastSearchCell.identifier, for: indexPath) as? PodcastSearchCell else {fatalError("Cell Doesn't Exist!")}
            cell.configure(podcast: podcast)
            return cell
        })
        
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.podcasts)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func reloadData() {
        applySnapshot()
    }
}

extension SearchTableController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let podcast = dataSource.itemIdentifier(for: indexPath) else { return }
        navigateToDetailsScreen(podcast: podcast)
    }
    
    private func navigateToDetailsScreen(podcast: Podcast){
        delegate?.didSelectPodcast(podcast: podcast)
    }
}
