//
//  MHRequestProtocol.swift
//  MyHeritageHomeTest
//
//  Created by elad schwartz on 10/06/2022.
//

import Foundation

protocol MHRequestProtocol {
    var host       : String { get }
    var path       : String { get }
    var headers    : [String: String] { get }
    var params     : [String: Any] { get }
    var urlParams  : [URLQueryItem] { get }
    var method     : HTTPMethod { get }
    
}

extension MHRequestProtocol {
    var scheme : String{
        "https"
    }
    
    var host : String {
        MHAPIConstant.host
    }
    
    var headers : [String: String]  {
        [:]
    }
    
    var params : [String: Any] {
        [:]
    }
    
    var urlParams : [URLQueryItem]  {
        []
    }
    
    func createURLRequest() throws -> URLRequest {
        var components    = URLComponents()
        components.scheme = scheme
        components.host   = host
        components.path   = path
        
        if !urlParams.isEmpty { components.queryItems = urlParams }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        if !headers.isEmpty { urlRequest.allHTTPHeaderFields = headers }
        if !params.isEmpty  { urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params) }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}


