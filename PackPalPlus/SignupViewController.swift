import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.placeholder = "이메일 입력"
        passwordTextField.placeholder = "비밀번호 입력"
        confirmTextField.placeholder = "비밀번호 확인"

        passwordTextField.isSecureTextEntry = true
        confirmTextField.isSecureTextEntry = true
    }

    @IBAction func signupCompleteTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirm = confirmTextField.text, !confirm.isEmpty else {
            showAlert(message: "모든 항목을 입력해주세요.")
            return
        }

        guard password == confirm else {
            showAlert(message: "비밀번호가 일치하지 않습니다.")
            return
        }

        // 모든 조건 통과 시 → TravelInfo 화면으로 이동
        performSegue(withIdentifier: "toTravelInfoFromSignup", sender: nil)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
