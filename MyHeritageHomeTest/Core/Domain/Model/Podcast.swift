//
//  Podcast.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

struct RootResults  : Decodable{
    let results : [Podcast]
}

struct Podcast : Decodable, Hashable {
    let trackId       : Int
    let artistName    : String
    let trackName     : String
    let artworkUrl100 : String
    let releaseDate   : Date
}
