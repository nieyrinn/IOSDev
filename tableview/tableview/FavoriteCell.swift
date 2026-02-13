import UIKit

class FavoriteCell: UITableViewCell {

        @IBOutlet weak var thumbImageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var subtitleLabel: UILabel!
        @IBOutlet weak var reviewLabel: UILabel!

        func configure(with item: FavoriteItem) {
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
            reviewLabel.text = item.review

            if let name = item.imageName,
               let image = UIImage(named: name) {
                thumbImageView.image = image
            }
        }
    }
