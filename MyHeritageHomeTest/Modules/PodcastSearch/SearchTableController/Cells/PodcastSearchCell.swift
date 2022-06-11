//
//  PodcastSearchCell.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import UIKit
import SDWebImage

class PodcastSearchCell : UITableViewCell{
    
    static let identifier = "PodcastSearchCell"
    
    @IBOutlet weak var podcastImageView : UIImageView!
    @IBOutlet weak var artistNameLabel  : UILabel!
    @IBOutlet weak var trackNameLabel   : UILabel!
    
    func configure(podcast: Podcast){
        artistNameLabel.text = podcast.artistName
        trackNameLabel.text  = podcast.trackName
      
        if let imageUrl = URL(string: podcast.artworkUrl100) {
            podcastImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            podcastImageView.makeCircular()
        }
    }
}
