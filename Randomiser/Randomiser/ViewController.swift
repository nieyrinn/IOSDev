import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributesStackView: UIStackView!

    // MARK: - Data
    private var items: [Item] = []
    private var lastIndex: Int?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadItems()
        showRandomItem(animated: false) // initial
    }

    // MARK: - Setup
    private func setupUI() {
        itemImageView.layer.cornerRadius = 12
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFit

        view.backgroundColor = .systemBackground

        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textAlignment = .center

        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        attributesStackView.axis = .horizontal
        attributesStackView.alignment = .center
        attributesStackView.spacing = 8
        attributesStackView.distribution = .fillProportionally
    }

    private func loadItems() {
        items = [
            Item(title: "Rose", imageName: "flower_rose", description: "A classic symbol of love.", attributes: ["origin: asia", "rating: 4.8"]),
            Item(title: "Tulip", imageName: "flower_tulip", description: "Spring bulb with elegant shape.", attributes: ["origin: europe", "rating: 4.5"]),
            Item(title: "Lily", imageName: "flower_lily", description: "Fragrant and graceful.", attributes: ["origin: asia", "rating: 4.6"]),
            Item(title: "Sunflower", imageName: "flower_sunflower", description: "Bright and tall, follows the sun.", attributes: ["origin: north america", "rating: 4.7"]),
            Item(title: "Daisy", imageName: "flower_daisy", description: "Simple and cheerful.", attributes: ["origin: europe", "rating: 4.2"]),
            Item(title: "Orchid", imageName: "flower_orchid", description: "Exotic and delicate.", attributes: ["origin: asia", "rating: 4.9"]),
            Item(title: "Peony", imageName: "flower_peony", description: "Lush petals and sweet smell.", attributes: ["origin: china", "rating: 4.6"]),
            Item(title: "Iris", imageName: "flower_iris", description: "Distinctive shape, many colors.", attributes: ["origin: europe", "rating: 4.3"]),
            Item(title: "Marigold", imageName: "flower_marigold", description: "Golden orange, often used in festivals.", attributes: ["origin: south america", "rating: 4.1"]),
            Item(title: "Cherry Blossom", imageName: "flower_cherryblossom", description: "Short-lived but spectacular.", attributes: ["origin: japan", "rating: 4.9"])
        ]
    }

    // MARK: - Actions
    @IBAction func randomizeTapped(_ sender: UIButton) {
        showRandomItem(animated: true)
    }

    // MARK: - Helpers
    private func showRandomItem(animated: Bool) {
        guard !items.isEmpty else { return }

        var index = Int.random(in: 0..<items.count)
        if items.count > 1 {
            while index == lastIndex {
                index = Int.random(in: 0..<items.count)
            }
        }
        lastIndex = index
        let item = items[index]

        titleLabel.text = item.title
        descriptionLabel.text = item.description ?? ""
        updateAttributes(for: item)

        if let img = UIImage(named: item.imageName) {
            if animated {
                UIView.transition(with: itemImageView, duration: 0.45, options: .transitionCrossDissolve, animations: {
                    self.itemImageView.image = img
                }, completion: nil)
            } else {
                itemImageView.image = img
            }
        } else {
            // fallback
            itemImageView.image = nil
        }
    }

    private func updateAttributes(for item: Item) {
        attributesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        guard let attrs = item.attributes else { return }

        for a in attrs {
            let label = PaddingLabel()
            label.text = a
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textAlignment = .center
            label.layer.cornerRadius = 12
            label.clipsToBounds = true
            label.numberOfLines = 1
            label.backgroundColor = UIColor.secondarySystemFill
            label.setContentHuggingPriority(.required, for: .horizontal)
            attributesStackView.addArrangedSubview(label)
        }
    }
}

class PaddingLabel: UILabel {
    let inset = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    override var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        return CGSize(width: s.width + inset.left + inset.right,
                      height: s.height + inset.top + inset.bottom)
    }
}
