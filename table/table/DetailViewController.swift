import UIKit

final class DetailViewController: UIViewController {

    var item: Item!

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        guard let item = item else { return }

        coverImage.image = UIImage(named: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        reviewTitleLabel.text = "I really enjoyed this one. It stands out with its atmosphere, ideas, and overall execution. It was engaging from start to finish, and I genuinely appreciate the creativity and quality behind it. Definitely something I’m glad I experienced, and I’d recommend it to others as well."
        reviewLabel.text = item.review
    }
}
