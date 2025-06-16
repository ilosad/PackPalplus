import UIKit

class TravelInfoViewController: UIViewController {

    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
    }

    @IBAction func createListButtonTapped(_ sender: UIButton) {
        // 여행지 입력 검사
        guard let destination = destinationTextField.text, !destination.isEmpty else {
            showAlert(message: "여행지를 입력해주세요.")
            return
        }

        // 날짜 값
        let selectedDate = datePicker.date

        // 화면 전환
        performSegue(withIdentifier: "toGPTList", sender: (destination, selectedDate))
    }

    // Segue로 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGPTList",
           let nextVC = segue.destination as? GPTPackListViewController,
           let (destination, date) = sender as? (String, Date) {
            nextVC.destination = destination
            nextVC.travelDate = date
        }
    }

    // 알림창 표시
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
