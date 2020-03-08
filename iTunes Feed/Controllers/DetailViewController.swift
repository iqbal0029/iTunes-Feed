//
//  DetailViewController.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 5/24/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentNameLabel: UILabel!
    @IBOutlet weak var contentAuthorButton: UIButton!
    @IBOutlet weak var contentOpenButton: UIButton!
    @IBOutlet weak var contentKindLabel: UILabel!
    @IBOutlet weak var contentReleaseDateLabel: UILabel!
    @IBOutlet weak var contentGenresLabel: UILabel!
    @IBOutlet weak var contentCopyrightLabel: UILabel!
    
    var detailItem: Content? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        // Update the user interface for the detail item.
        guard let detail = detailItem, isViewLoaded else { return }
        contentImageView.setImage(fromURL: detail.artworkUrl100)
        contentNameLabel.text = detail.name

        contentAuthorButton.setTitle(detail.artistName, for: .normal)
        contentAuthorButton.isEnabled = detail.artistUrl != nil
        contentOpenButton.setTitle("Open: \(detail.name)", for: .normal)

        contentKindLabel.text = "Kind: \(detail.kind)"
        contentReleaseDateLabel.text = "Release date: \(detail.releaseDate)"

        let genres = detail.genres.map{ $0.name }.joined(separator: ", ")

        contentGenresLabel.text = "Genres: \(genres)"
        if let copyright = detail.copyright {
            contentCopyrightLabel.text = "Copyright \(copyright)"
        }

    }

    @IBAction func artistButtonPressed(_ sender: Any) {
        guard let artistURL = detailItem?.artistUrl else { return }
        openURL(urlString: artistURL)
    }

    @IBAction func contentOpenPressed(_ sender: Any) {
        guard let contentURL = detailItem?.url else { return }
        openURL(urlString: contentURL)
    }

    func openURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        print(url)
        UIApplication.shared.open(url)
    }
}

