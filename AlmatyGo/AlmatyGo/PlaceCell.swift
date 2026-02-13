import UIKit

final class PlaceCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    var onStarTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()

        placeImageView.clipsToBounds = true
        placeImageView.contentMode = .scaleAspectFill
        placeImageView.layer.cornerRadius = 14

        starImageView.contentMode = .scaleAspectFit
        starImageView.tintColor = .systemYellow
        starImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(starTapped))
        starImageView.addGestureRecognizer(tap)
    }

    @objc private func starTapped() {
        onStarTapped?()
    }

    func configure(with item: PlaceItem, isFavorite: Bool) {
        let p = item.place
        titleLabel.text = p.name
        subtitleLabel.text = "\(item.categoryTitle) • \(p.type) • ~\(p.avg_price)₸"

        placeImageView.image = UIImage(named: p.id) ?? UIImage(systemName: "photo")

        let starName = isFavorite ? "star.fill" : "star"
        starImageView.image = UIImage(systemName: starName)
    }
}
