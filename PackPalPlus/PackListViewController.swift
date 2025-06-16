import UIKit

class PackListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var tableView: UITableView!
    // 전달받은 여행 정보
    var destination: String = ""
    var travelDate: Date = Date()

    // 샘플 짐 목록 (임시 데이터)
    var items: [String] = ["칫솔", "여권", "충전기"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        print("🧳 여행지: \(destination)")
        print("📅 여행 날짜: \(travelDate)")
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // "ItemCell"은 스토리보드에서 설정한 Identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
