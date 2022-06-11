//
//  DataParser.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

protocol DataParserProtocol {
  func parse<T: Decodable>(data: Data) throws -> T
}

class DataParser: DataParserProtocol {
  private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder(), codingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
    self.jsonDecoder                     = jsonDecoder
    self.jsonDecoder.keyDecodingStrategy = codingStrategy
        self.jsonDecoder.dateDecodingStrategy = .iso8601
  }

  func parse<T: Decodable>(data: Data) throws -> T {
    return try jsonDecoder.decode(T.self, from: data)
  }
}
