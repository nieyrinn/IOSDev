import UIKit

final class CoursesViewController: FavoritesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Courses"
        self.items = data.course
    }
}
