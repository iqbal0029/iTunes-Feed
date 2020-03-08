//
//  MediaType.swift
//  iTunes Feed
//
//  Created by Faisal Iqbal on 5/25/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

//This repersent all currently supported MediaTypes
enum MediaType: String, CaseIterable, Codable {
    case apple_music = "Apple Music"
    case iTune_music = "iTunes Music"
    case iOS_apps = "iOS Apps"
    case audiobooks = "Audiobooks"
    case books = "Books"

    //This is to show in setting UI if MediaType changed
    var firstFeedType: String {
        switch self {
        case .apple_music:
            return AppleMusicFeedType.allCases.first?.rawValue ?? ""
        case .iTune_music:
            return iTuneMusicFeedType.allCases.first?.rawValue ?? ""
        case .iOS_apps:
            return iOSAppsFeedType.allCases.first?.rawValue ?? ""
        case .audiobooks:
            return AudiobooksFeedType.allCases.first?.rawValue ?? ""
        case .books:
            return BooksFeedType.allCases.first?.rawValue ?? ""
        }
    }

    //This is required while choosing different Feed Type in pickerView
    var allFeedType: [String] {
        switch self {
        case .apple_music:
            return AppleMusicFeedType.allCases.map { $0.rawValue }
        case .iTune_music:
            return iTuneMusicFeedType.allCases.map { $0.rawValue }
        case .iOS_apps:
            return iOSAppsFeedType.allCases.map { $0.rawValue }
        case .audiobooks:
            return AudiobooksFeedType.allCases.map { $0.rawValue }
        case .books:
            return BooksFeedType.allCases.map { $0.rawValue }
        }
    }

    //This is required while constructing endPoint URL
    var pathComponent: String {
        switch self {
        case .apple_music:
            return "apple-music"
        case .iTune_music:
            return "itunes-music"
        case .iOS_apps:
            return "ios-apps"
        case .audiobooks:
            return "audiobooks"
        case .books:
            return "books"
        }
    }
    
    func pathComponent(of feedType: String) -> String {
        switch self {
        case .apple_music:
            return AppleMusicFeedType(rawValue: feedType)?.pathComponent ?? ""
        case .iTune_music:
            return iTuneMusicFeedType(rawValue: feedType)?.pathComponent ?? ""
        case .iOS_apps:
            return iOSAppsFeedType(rawValue: feedType)?.pathComponent ?? ""
        case .audiobooks:
            return AudiobooksFeedType(rawValue: feedType)?.pathComponent ?? ""
        case .books:
            return BooksFeedType(rawValue: feedType)?.pathComponent ?? ""
        }
    }
}
