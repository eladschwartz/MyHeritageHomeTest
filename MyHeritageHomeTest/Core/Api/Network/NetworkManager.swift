//
//  NetworkManager.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: MHRequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerProtocol {
  let apiManager    : MHAPIManagerProtocol
  let parser        : DataParserProtocol

    init(apiManager  : MHAPIManagerProtocol  = MHAPIManager(),
         parser      : DataParserProtocol    = DataParser()) {
        
        self.apiManager = apiManager
        self.parser     = parser
    }
    
  func perform<T: Decodable>(_ request: MHRequestProtocol) async throws -> T {
    let data = try await apiManager.perform(request)
    let decoded: T = try parser.parse(data: data)
    return decoded
  }
}
