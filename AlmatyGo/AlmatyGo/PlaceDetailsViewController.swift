import UIKit

final class PlaceDetailsViewController: UIViewController {

    private let item: PlaceItem
    private var images: [UIImage] = []
    private var index = 0
    private let imageView = UIImageView()
    private let prevButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let infoLabel = UILabel()


    init(item: PlaceItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let p = item.place
        title = p.name

        images = (1...3).compactMap { UIImage(named: "\(p.id)_\($0)") }
        if images.isEmpty {
            images = [UIImage(named: p.id)].compactMap { $0 }
        }

        setupUI()
        showImage()



        infoLabel.numberOfLines = 0
        infoLabel.textColor = .black
        infoLabel.text =
        """
        \(item.categoryTitle) • \(p.type)
        \(p.address)
        Time: \(p.open_hours)
        Peak-Time: \(p.rush_hours)
        Average Price: \(p.avg_price)₸
        """
    }

    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18

        prevButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        prevButton.setTitle("←", for: .normal)
        nextButton.setTitle("→", for: .normal)

        prevButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        nextButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)

        prevButton.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        view.addSubview(imageView)
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        view.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 240),

            prevButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            prevButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),

            nextButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            nextButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 12),
            infoLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }

    private func showImage() {
        guard !images.isEmpty else {
            imageView.image = UIImage(systemName: "photo")
            return
        }

        UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve) {
            self.imageView.image = self.images[self.index]
        }
    }

    @objc private func prevTapped() {
        guard !images.isEmpty else { return }
        index = (index - 1 + images.count) % images.count
        showImage()
    }


    @objc private func nextTapped() {
        guard !images.isEmpty else { return }
        index = (index + 1) % images.count
        showImage()
    }

}
