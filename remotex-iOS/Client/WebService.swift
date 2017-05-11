//
//  WebService.swift
//  remotex-iOS
//
//  Created by archimboldi on 10/05/2017.
//  Copyright © 2017 me.archimboldi. All rights reserved.
//

import Foundation

final class WebService {
    
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            let result = self.checkForNetworkErrors(data, response, error)
            
            switch result {
            case .success (let data):
                completion(resource.parse(data))
            case .failure (let error):
                completion(.failure(error))
            }
        }.resume()
    }
}

extension WebService {
    fileprivate func checkForNetworkErrors(_ data: Data?, _ response: URLResponse? , _ error: Error?) -> Result<Data> {
        guard error == nil else {
            if (error! as NSError).domain == NSURLErrorDomain && ((error! as NSError).code == NSURLErrorNotConnectedToInternet || (error! as NSError).code == NSURLErrorTimedOut) {
                return .failure(.noInternetConnection)
            } else {
                return .failure(.returnedError(error!))
            }
        }
        
        guard let data = data else {
            return .failure(.dataReturnedNil)
        }
        
        return .success(data)
    }
}

struct Resource<A> {
    let url: URL
    let parse: (Data) -> Result<A>
}

extension Resource {
    
    init(url: URL, parseJSON: @escaping (Any) -> Result<A>) {
        self.url = url
        self.parse = { data in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                return parseJSON(jsonData)
            } catch {
                fatalError("Error parsing data")
            }
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(NetworkingErrors)
}

enum NetworkingErrors: Error {
    case errorParsingJSON
    case noInternetConnection
    case dataReturnedNil
    case returnedError(Error)
    case invalidStatusCode(String)
    case customError(String)
}
