import UIKit

// 1단계: 프로토콜 정의
protocol AddItemDelegate: AnyObject {
    func didAddItem(_ item: String)
}

class AddItemViewController: UIViewController {

    // 2단계: 위임(delegate)을 받을 변수 선언
    weak var delegate: AddItemDelegate?

    // 3단계: IBOutlet 연결
    @IBOutlet weak var itemTextField: UITextField!

    // 4단계: 추가 버튼 눌렀을 때
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let newItem = itemTextField.text ?? ""

        // 입력값이 비어있지 않을 때만 처리
        if !newItem.isEmpty {
            // 5단계: delegate에게 항목 전달
            delegate?.didAddItem(newItem)
        }

        // 현재 화면 닫기 (모달 dismiss)
        self.dismiss(animated: true, completion: nil)
    }

    // 6단계: 취소 버튼 눌렀을 때 (선택)
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
