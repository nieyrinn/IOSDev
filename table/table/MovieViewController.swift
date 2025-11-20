import Foundation
import UIKit

final class MoviesViewController: FavoritesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.items = data.movie
    }
}
