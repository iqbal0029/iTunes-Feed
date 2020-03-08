//
//  Extension.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/26/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit
extension UIImageView {
    func setImage(fromURL link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        image = UIImage(named: "placeHolder.png")
        downloaded(from: url, contentMode: mode)
    }

    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}

extension Bundle {
    static var supportedCountry: [String: String] {
        if let path = main.path(forResource: "Country", ofType: "plist") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return try! PropertyListDecoder().decode([String: String].self, from: data)
            }
        }
        return [:]
    }
}

extension String {
    func first(splitBy: String) -> String? {
        guard let first = split(separator: "T").first else { return nil }
        return String(first)
    }
}
