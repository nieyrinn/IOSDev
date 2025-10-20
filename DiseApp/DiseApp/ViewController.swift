import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rightDiceImageView: UIImageView!
    @IBOutlet weak var leftDiceImageView: UIImageView!
    

    let diceImages = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        rollDice()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        rollDice()
    }

    func rollDice() {
        leftDiceImageView.image = UIImage(named: diceImages.randomElement()!)
        rightDiceImageView.image = UIImage(named: diceImages.randomElement()!)
    }
}
