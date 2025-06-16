import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
}
