//
//  iTunesSearchRequest.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

enum iTunesSearchRequest : MHRequestProtocol{
    case search(searchText: String?)
    
    var path: String {
        switch self {
            case .search(_):
                return "/search"
        } }
    
    var urlParams: [URLQueryItem] {
        var params = [URLQueryItem]()
        switch self {
            case .search(let searchText):
                params.append(URLQueryItem(name: "term", value:searchText))
                params.append(URLQueryItem(name: "entity", value:"podcast"))
                return params
        }
    }
    var method: HTTPMethod {
        switch self {
            case .search:
                return .get
        } }
}
