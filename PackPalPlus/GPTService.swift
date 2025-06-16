import Foundation

class GPTService {
    static let shared = GPTService()
    private init() {}

    private let endpoint = "https://api.openai.com/v1/chat/completions"

    func generatePackList(destination: String, date: String, completion: @escaping ([String]?) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "OpenAI_API_Key") as? String else {
            print("❌ API 키가 없습니다.")
            completion(nil)
            return
        }

        let messages: [[String: String]] = [
            ["role": "system", "content": "너는 사용자의 여행 목적지와 날짜를 참고해 꼭 필요한 짐 목록을 한국어로 추천해주는 AI 도우미야. 결과는 ['여권', '의류', '세면도구'] 같은 형식의 배열로 출력해줘."],
            ["role": "user", "content": "\(destination)로 \(date)에 여행 갈 예정이야. 챙겨야 할 짐 리스트를 알려줘."]
        ]

        let requestData: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7
        ]

        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("❌ 네트워크 오류: \(error?.localizedDescription ?? "unknown")")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    
                    // GPT 응답 → ["여권", "칫솔", "충전기"] 형태로 변환
                    let cleaned = content
                        .replacingOccurrences(of: "[", with: "")
                        .replacingOccurrences(of: "]", with: "")
                        .replacingOccurrences(of: "\"", with: "")
                        .replacingOccurrences(of: "'", with: "")
                    let items = cleaned.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    completion(items)
                } else {
                    print("❌ JSON 파싱 실패")
                    completion(nil)
                }
            } catch {
                print("❌ 응답 디코딩 실패: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
