//
//  PodcastDetailsViewController.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import UIKit

class PodcastDetailsViewController : UIViewController {
    
    @IBOutlet weak var podcastImageView : UIImageView!
    @IBOutlet weak var artistLabel      : UILabel!
    @IBOutlet weak var trackLabel       : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    
    private var viewModel : PodcastDetailsViewModel
    
    init?(viewModel: PodcastDetailsViewModel, coder: NSCoder) {
          self.viewModel = viewModel
          super.init(coder: coder)
      }
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI(){
        artistLabel.text      = "Artist Name: \(viewModel.artistName)"
        trackLabel.text       = "Track Name: \(viewModel.trackName)"
        
        let releaseDate = DateFormatter.timeStampFormatter.string(from: viewModel.releaseDate)
        releaseDateLabel.text = "Release Date: \(releaseDate)"
        if let imageUrl = URL(string: viewModel.imageUrlString) {
            podcastImageView.sd_setImage(with: imageUrl)
            podcastImageView.makeCircular()
        }
    }

      @available(*, unavailable, renamed: "init(product:coder:)")
      required init?(coder: NSCoder) {
          fatalError("Invalid way of decoding this class")
      }
}
