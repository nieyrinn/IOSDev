//
//  FavoriteCell.swift
//  tableview
//
//  Created by nieyrinn on 14.11.2025.
//

import UIKit

class FavoriteCell: UITableViewCell {

        @IBOutlet weak var thumbImageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var subtitleLabel: UILabel!
        @IBOutlet weak var reviewLabel: UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()
            thumbImageView.layer.cornerRadius = 8
            thumbImageView.clipsToBounds = true

            titleLabel.font = .preferredFont(forTextStyle: .title3)
            titleLabel.adjustsFontForContentSizeCategory = true

            subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
            subtitleLabel.textColor = .secondaryLabel

            reviewLabel.font = .preferredFont(forTextStyle: .body)
            reviewLabel.numberOfLines = 0
        }

        func configure(with item: FavoriteItem) {
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
            reviewLabel.text = item.review

            if let name = item.imageName,
               let image = UIImage(named: name) {
                thumbImageView.image = image
            } else if let symbol = item.sfSymbol {
                thumbImageView.image = UIImage(systemName: symbol)
            } else {
                thumbImageView.image = UIImage(systemName: "photo")
            }
        }
    }
