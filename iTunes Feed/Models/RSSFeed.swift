//
//  Feed.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/24/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import Foundation

///This manages RSSFeed setting and create final endPoint URL to fetch contents
final class RSSFeed: Codable {
    static private(set) var `default` = RSSFeed()
    private init() {}
    
    var country = "United States"
    var mediaType: MediaType = .apple_music {
        didSet { selectedFeedType = mediaType.firstFeedType }
    }
    var selectedFeedType = "Coming Soon"
    var resultLimit = "10"
    var isAllowedExplicit = true
}

//MARK: Archiving
extension RSSFeed {
    ///Load last user feed settings from userdefault
    static func unarchiveRSSFeed() {
        let userDefaultSettingKey = R.UserDefault.settingData.rawValue
        guard
            let data = UserDefaults.standard.data(forKey: userDefaultSettingKey),
            let setting = try? JSONDecoder().decode(RSSFeed.self, from: data)
            else { return }
        RSSFeed.default = setting
    }

    ///Save feed settings to userdefault
    static func archiveRSSFeed() {
        if let settings = try? JSONEncoder().encode(RSSFeed.default) {
            let settingDataKey = R.UserDefault.settingData.rawValue
            UserDefaults.standard.setValue(settings, forKey: settingDataKey)
        }
    }
}

//MARK: Helpers
extension RSSFeed {
    var endPoint: URL {
        let baseURL = URL(string: R.URLS.base.rawValue)!
        let genre = "all"
        var completedURL = baseURL.appendingPathComponent(selectedCountryCode)
        completedURL.appendPathComponent(mediaType.pathComponent)
        completedURL.appendPathComponent(mediaType.pathComponent(of: selectedFeedType))
        completedURL.appendPathComponent(genre)
        completedURL.appendPathComponent(resultLimit)
        completedURL.appendPathComponent(isAllowedExplicit ? "explicit" : "non-explicit")
        completedURL.appendPathExtension("json")
        return completedURL
    }
    
    var supportedCountry: [String] {
        return Array(Bundle.supportedCountry.keys).sorted()
    }
    
    var selectedCountryCode: String {
        return Bundle.supportedCountry[country, default: "US"].lowercased()
    }
    
    var supportedMediaType: [String] {
        return MediaType.allCases.map { $0.rawValue }
    }
    
    var supportedResultLimit: [String] {
        return ["10", "25", "50", "100"]
    }
}
