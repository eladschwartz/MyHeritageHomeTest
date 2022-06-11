//
//  MHAPIManager.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

protocol MHAPIManagerProtocol {
  func perform(_ request: MHRequestProtocol) async throws -> Data
}

class MHAPIManager: MHAPIManagerProtocol {
  private let urlSession: URLSession

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func perform(_ request: MHRequestProtocol) async throws -> Data {
    let urlRequest       = try request.createURLRequest()
    let (data, response) = try await urlSession.data(for: urlRequest)
      
    guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
    return data
  }
}
