import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var logo: UIImageView!

    @IBAction func didTapGetStarted(_ sender: UIButton) {
        sender.isEnabled = false

        UIView.animate(withDuration: 0.18, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.view.alpha = 0.92
        }, completion: { _ in
            guard let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") else { return }
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logo.alpha = 0
        logo.transform = CGAffineTransform(translationX: 0, y: 30).scaledBy(x: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseOut]) {
            self.logo.alpha = 1
            self.logo.transform = .identity
        }
    }


}
