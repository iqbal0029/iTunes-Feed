//
//  Resource.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/25/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import Foundation

//This manages Constants
enum R {
    enum Segue: String {
        case showDetail
        case showSetting
    }
    
    enum UserDefault: String {
        case settingData
    }
    
    enum URLS: String {
        case base = "https://rss.itunes.apple.com/api/v1"
    }

    enum TableCell: String {
        case preview = "PreviewTableViewCell"
        case detail = "DetailTableViewCell"
    }
}
