//
//  PreviewTableViewCell.swift
//  iTunes Feed
//
//  Created by Faisal Ikwal on 27/05/19.
//  Copyright © 2019 Faisal Ikwal. All rights reserved.
//

import UIKit

final class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var contentPreviewImageView: UIImageView!
    @IBOutlet weak var contentNameLabel: UILabel!
    @IBOutlet weak var contentArtistNameLabel: UILabel!
    @IBOutlet weak var contentReleaseLabel: UILabel!
    @IBOutlet weak var contentCopyrightLabel: UILabel!

    func update(with cellContent: PreviewTableViewModel) {
        contentPreviewImageView.setImage(fromURL: cellContent.imageURL)
        contentNameLabel.text = cellContent.name
        contentArtistNameLabel.text = cellContent.artistName
        contentReleaseLabel.text = cellContent.formattedReleasedate
        contentCopyrightLabel.text = cellContent.formattedCopyright
    }
}
