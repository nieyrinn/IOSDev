import Foundation
import UIKit

final class MusicViewController: FavoritesListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Music"
        self.items = data.music
    }
}
