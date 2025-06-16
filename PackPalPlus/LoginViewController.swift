import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 디자인 예쁘게
        idTextField.placeholder = "아이디를 입력하세요"
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 일단은 바로 TravelInfo 화면으로 이동
        performSegue(withIdentifier: "toTravelInfoFromLogin", sender: nil)
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        // 회원가입 화면으로 이동
        performSegue(withIdentifier: "toSignup", sender: nil)
    }
}
