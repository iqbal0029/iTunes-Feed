//
//  RSSFeedType.swift
//  iTunes Feed
//
//  Created by Faisal Iqbal on 5/25/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

//This file repersent different Feed Type

enum AppleMusicFeedType: String, CaseIterable {
    case coming_soon = "Coming Soon"
    case hot_tracks = "Hot Tracks"
    case new_release = "New Releases"
    case top_albums = "Top Albums"
    case top_song = "Top Songs"

    //This is required while constructing endPoint URL
    var pathComponent: String {
        switch self {
        case .coming_soon:
            return "coming-soon"
        case .hot_tracks:
            return "hot-tracks"
        case .new_release:
            return "new-releases"
        case .top_albums:
            return "top-albums"
        case .top_song:
            return "top-songs"
        }
    }
}

enum iTuneMusicFeedType: String, CaseIterable {
    case hot_tracks = "Hot Tracks"
    case new_release = "New Releases"
    case top_albums = "Top Albums"
    case top_song = "Top Songs"
    
    var pathComponent: String {
        switch self {
        case .hot_tracks:
            return "hot-tracks"
        case .new_release:
            return "new-releases"
        case .top_albums:
            return "top-albums"
        case .top_song:
            return "top-songs"
        }
    }
}

enum iOSAppsFeedType: String, CaseIterable {
    case new_apps_we_love = "New Apps We Love"
    case new_games_we_love = "New Games We Love"
    case top_free = "Top Free"
    case top_free_iPad = "Top Free iPad"
    case top_grossing = "Top Grossing"
    case top_grossing_iPad = "Top Grossing iPad"
    case top_paid = "Top Paid"
    
    var pathComponent: String {
        switch self {
        case .new_apps_we_love:
            return "new-apps-we-love"
        case .new_games_we_love:
            return "new-games-we-love"
        case .top_free:
            return "top-free"
        case .top_free_iPad:
            return "top-free-ipad"
        case .top_grossing:
            return "top-grossing"
        case .top_grossing_iPad:
            return "top-grossing-ipad"
        case .top_paid:
            return "top-paid"
        }
    }
}

enum AudiobooksFeedType: String, CaseIterable {
    case top_audiobooks = "Top Audiobooks"
    
    var pathComponent: String {
        switch self {
        case .top_audiobooks:
            return "top-audiobooks"
        }
    }
}

enum BooksFeedType: String, CaseIterable {
    case top_free = "Top Free"
    case top_paid = "Top Paid"
    
    var pathComponent: String {
        switch self {
        case .top_free:
            return "top-free"
        case .top_paid:
            return "top-paid"
        }
    }
}
