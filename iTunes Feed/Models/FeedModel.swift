//
//  FeedModel.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/26/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import Foundation

//This repersent full content of Music, Apps, Books etc
struct Feed: Codable {
    let title: String
    let updated: String
    let results: [Content]
}

//This repersent individual Music, Apps, Books etc
struct Content: Codable {
    let artistName: String
    let releaseDate: String
    let name: String
    let kind: String
    let copyright: String?
    let artistUrl: String?
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

struct Genre: Codable {
    let name: String
    let url: String
}
