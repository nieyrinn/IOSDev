import UIKit

final class BooksViewController: FavoritesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books"
        self.items = data.book
    }
}
