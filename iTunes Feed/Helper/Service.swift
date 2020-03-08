//
//  Service.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/26/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import Foundation

enum FeedError: String, Error {
    case invalidUrl
    case parshingError = "No Content"
    case invalidData
    
    var description: String {
        return rawValue
    }
}

final class Service {
    static func fetchContentsFrom(url: URL, completion:@escaping ((Result<Feed, FeedError>) -> Void)) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            if let result = try? JSONDecoder().decode([String: Feed].self, from: data),
                let json = result["feed"] {
                completion(.success(json))
            } else {
                completion(.failure(.parshingError))
            }
        }.resume()
    }
}
