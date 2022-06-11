//
//  NetworkError.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidServerResponse
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
            case .invalidServerResponse:
                return "The server returned an invalid response."
            case .invalidURL:
                return "Invalid URL"
        }
    }
}
