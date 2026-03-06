import UIKit
import SwiftUI

class AppRouter {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = AlbumsViewModel()
        let view = AlbumsView(viewModel: viewModel, onAlbumTap: { [weak self] album in
            print("Album tapped: \(album.collectionName)")
            self?.showTracks(for: album)
        })
        let hostingController = UIHostingController(rootView: view)
        hostingController.title = "Albums"
        navigationController.setViewControllers([hostingController], animated: false)
    }

    func showTracks(for album: Album) {
        print("showTracks called for: \(album.collectionName)")
        let viewModel = TracksViewModel(album: album)
        let view = TracksView(viewModel: viewModel, onTrackTap: { [weak self] track in
            self?.showPlayer(for: track)
        })
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }

    func showPlayer(for track: Track) {
        let viewModel = PlayerViewModel(track: track)
        let view = PlayerView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
