import UIKit

class GPTPackListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var regenerateButton: UIButton!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet weak var addItemButton: UIButton!

    // MARK: - Properties
    var destination: String = ""
    var travelDate: Date = Date()
    var items: [String] = []
    var checkedStates: [Bool] = []
    var filteredItems: [(index: Int, text: String)] = []

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension

        filterSegment.selectedSegmentIndex = 0
        filterSegment.addTarget(self, action: #selector(filterChanged), for: .valueChanged)

        fetchGPTList()
    }

    // MARK: - GPT 호출 함수
    private func fetchGPTList() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ko_KR")
        let formattedDate = formatter.string(from: travelDate)

        GPTService.shared.generatePackList(destination: destination, date: formattedDate) { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.items = result
                    self?.checkedStates = Array(repeating: false, count: result.count)
                } else {
                    self?.items = ["❌ 짐 리스트를 불러오지 못했습니다."]
                    self?.checkedStates = [false]
                }
                self?.applyFilter()
            }
        }
    }

    // MARK: - 필터 변경 처리
    @objc private func filterChanged() {
        applyFilter()
    }

    private func applyFilter() {
        switch filterSegment.selectedSegmentIndex {
        case 1: // 완료
            filteredItems = items.enumerated().filter { checkedStates[$0.offset] }.map { ($0.offset, $0.element) }
        case 2: // 미완료
            filteredItems = items.enumerated().filter { !checkedStates[$0.offset] }.map { ($0.offset, $0.element) }
        default: // 전체
            filteredItems = items.enumerated().map { ($0.offset, $0.element) }
        }
        tableView.reloadData()
    }

    // MARK: - Actions
    @IBAction func regenerateListButtonTapped(_ sender: UIButton) {
        fetchGPTList()
    }

    @IBAction func addItemButtonTapped(_ sender: UIButton) {
        guard let newItem = addItemTextField.text, !newItem.isEmpty else { return }
        items.append(newItem)
        checkedStates.append(false)
        addItemTextField.text = ""
        applyFilter()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GPTItemCell", for: indexPath)
        let (originalIndex, text) = filteredItems[indexPath.row]

        cell.textLabel?.text = text
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.accessoryType = checkedStates[originalIndex] ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let originalIndex = filteredItems[indexPath.row].index
        checkedStates[originalIndex].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    // MARK: - 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let originalIndex = filteredItems[indexPath.row].index
            items.remove(at: originalIndex)
            checkedStates.remove(at: originalIndex)
            applyFilter()
        }
    }
}
