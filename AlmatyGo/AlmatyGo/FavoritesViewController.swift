import UIKit
import Foundation

final class FavoritesViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var allItems: [PlaceItem] = []
    private var favorites: [PlaceItem] = []

    override func viewDidLoad() {
        title = "Favorites"
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    private func load() {
        NetworkService.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }

                switch result {
                case .success(let root):
                    self.allItems = root.categories.flatMap { cat in
                        cat.places.map { PlaceItem(categoryId: cat.id, categoryTitle: cat.title, place: $0) }
                    }

                    let favIDs = FavoritesStore.shared.favoriteIDs
                    self.favorites = self.allItems.filter { favIDs.contains($0.place.id) }
                    self.tableView.reloadData()

                case .failure:
                    self.favorites = []
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "FavCell")

        let item = favorites[indexPath.row]
        let p = item.place

        cell.textLabel?.text = p.name
        cell.detailTextLabel?.text = "\(item.categoryTitle) • \(p.type) • ~\(p.avg_price)₸"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(
            PlaceDetailsViewController(item: favorites[indexPath.row]),
            animated: true
        )
    }
}
