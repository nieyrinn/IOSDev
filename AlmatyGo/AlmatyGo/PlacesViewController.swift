import UIKit

final class PlacesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var categories: [Category] = []
    private var allItems: [PlaceItem] = []
    private var filtered: [PlaceItem] = []
    private var selectedCategoryId: String = "all"
    private var categoryControl: UISegmentedControl?
    private let refreshControl = UIRefreshControl()
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearch()
        loadData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        loadData()
    }

    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    private func loadData() {
        NetworkService.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let root):
                    self.categories = root.categories

                    self.allItems = root.categories.flatMap { cat in
                    cat.places.map { PlaceItem(categoryId: cat.id, categoryTitle: cat.title, place: $0) }
                    }

                    self.setupCategoryControl()
                    self.applyFilters()

                case .failure(let error):
                    DispatchQueue.main.async {
                        self.allItems = []
                        self.filtered = []
                        self.tableView.reloadData()
                        self.showErrorAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }

    private func setupCategoryControl() {
        categoryControl?.removeFromSuperview()

        let titles = ["All"] + categories.map { $0.title }
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(categoryChanged), for: .valueChanged)

        navigationItem.titleView = control
        categoryControl = control
        selectedCategoryId = "all"
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Network error maybe :(", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }


    @objc private func categoryChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedCategoryId = "all"
        } else {
            selectedCategoryId = categories[sender.selectedSegmentIndex - 1].id
        }
        applyFilters()
    }

    private func applyFilters() {
        let text = searchController.searchBar.text?.lowercased() ?? ""
        let maxPrice = UserDefaults.standard.float(forKey: "maxPrice")

        filtered = allItems.filter { item in
            let matchesCategory =
                (selectedCategoryId == "all") ||
                (item.categoryId == selectedCategoryId)

            let p = item.place
            let hay = (p.name + " " + p.type + " " + p.address).lowercased()
            let matchesText = text.isEmpty || hay.contains(text)

            let matchesPrice = Float(p.avg_price) <= maxPrice

            return matchesCategory && matchesText && matchesPrice
        }

        tableView.reloadData()
    }
}

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtered.count
    }

    func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as? PlaceCell else {
            return UITableViewCell()
        }

        let item = filtered[indexPath.row]
        let fav = FavoritesStore.shared.isFavorite(item.place.id)
        cell.configure(with: item, isFavorite: fav)
        
        cell.onStarTapped = { [weak self] in
            guard let self else { return }
            let id = item.place.id
            FavoritesStore.shared.toggle(id)
            if let visibleCell = tableView.cellForRow(at: indexPath) as? PlaceCell {
                UIView.animate(withDuration: 0.12, animations: {
                    visibleCell.starImageView.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.12) {
                        visibleCell.starImageView.transform = .identity
                    }
                })
                let fav = FavoritesStore.shared.isFavorite(id)
                visibleCell.configure(with: item, isFavorite: fav)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = filtered[indexPath.row]
        navigationController?.pushViewController(
            PlaceDetailsViewController(item: item),
            animated: true
        )
    }
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        let item = filtered[indexPath.row]
        let id = item.place.id

        let title = FavoritesStore.shared.isFavorite(id) ? "Unfav" : "Fav"

        let action = UIContextualAction(style: .normal, title: title) { _, _, done in
            FavoritesStore.shared.toggle(id)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            done(true)
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension PlacesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        applyFilters()
    }
}
