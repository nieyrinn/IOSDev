import UIKit

final class FavoriteCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var review: UILabel!
    

    func configure(with item: Item) {
        coverImageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        review.text = item.review
    }
}
