//
//  PreviewTableViewModel.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 27/05/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

struct PreviewTableViewModel {
    let imageURL: String
    let name: String
    let artistName: String
    let releaseDate: String
    let copyright: String?

    var formattedReleasedate: String {
        return "Release Date: \(releaseDate)"
    }

    var formattedCopyright: String {
        guard let copyright = copyright else { return "" }
        return "Copyright \(copyright)"
    }
}
