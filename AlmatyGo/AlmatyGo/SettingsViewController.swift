import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var aboutTextView: UITextView!
    @IBOutlet private weak var onlyOpenSwitch: UISwitch!
    @IBOutlet private weak var maxPriceSlider: UISlider!
    @IBOutlet private weak var priceValueLabel: UILabel!
    private let priceStep: Float = 500



    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My profile"
        loadSettings()
        updatePriceLabel()
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    private func loadSettings() {
        nameField.text = UserDefaults.standard.string(forKey: "userName") ?? ""
        aboutTextView.text = UserDefaults.standard.string(forKey: "about") ?? ""
        onlyOpenSwitch.isOn = UserDefaults.standard.bool(forKey: "onlyOpen")

        let savedPrice = UserDefaults.standard.integer(forKey: "maxPrice")
        if savedPrice != 0 {
            maxPriceSlider.value = Float(savedPrice)
        }
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        saveSettings()
    }
    
    private func saveSettings() {
        UserDefaults.standard.set(nameField.text ?? "", forKey: "userName")
        UserDefaults.standard.set(aboutTextView.text ?? "", forKey: "about")
        UserDefaults.standard.set(onlyOpenSwitch.isOn, forKey: "onlyOpen")
        UserDefaults.standard.set(Int(maxPriceSlider.value), forKey: "maxPrice")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
    }
    
    @IBAction func priceChanged(_ sender: UISlider) {
        let rounded = round(sender.value / priceStep) * priceStep
        sender.value = rounded
        updatePriceLabel()
    }
    private func updatePriceLabel() {
        let value = Int(maxPriceSlider.value)
        priceValueLabel.text = "\(value) ₸"
    }


}
