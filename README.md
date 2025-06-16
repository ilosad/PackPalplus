📦 PackPalPlus - AI 기반 여행 짐 리스트 도우미

✨ 개요
PackPalPlus는 사용자가 여행지와 날짜를 입력하면 **AI(GPT)**가 자동으로 맞춤형 짐 리스트를 생성해주는 스마트 여행 준비 앱입니다. 간편한 입력, 자동 리스트 생성, 체크리스트, 필터링, 사용자 커스텀 추가 기능까지 포함된, 실제로 사용 가능한 실용적인 iOS 앱입니다.

🛠 주요 기능
- GPT 짐 리스트 생성	OpenAI GPT API를 활용하여 여행지와 날짜에 맞는 맞춤형 짐 리스트 자동 생성
- 체크리스트	생성된 짐 항목을 체크/해제 가능
- 항목 삭제	필요 없는 짐 항목은 스와이프로 삭제 가능
- 필터 기능	전체 / 완료 / 미완료 항목을 세그먼티드 컨트롤로 필터링
- 사용자 추가 항목	사용자가 직접 짐을 입력 후 버튼 클릭으로 추가 가능
- 리스트 다시 생성	언제든지 버튼으로 리스트 재생성 가능
- UIScrollView 적용	전체 화면 스크롤 지원으로 작은 화면에서도 모든 UI 접근 가능

🧱 기술 스택
- Xcode (Storyboard 기반 UI)
- Swift / UIKit
- OpenAI GPT API
- CocoaPods로 Firebase 및 외부 라이브러리 관리
- Firebase 연동 준비 완료 (FirebaseCore 설치 및 초기화 완료)
- Auto Layout, UITableView, UISegmentedControl, ScrollView 사용
  
📂 구현 구조
주요 ViewController
- TravelInfoViewController	여행지와 날짜 입력 화면 (→ GPTPackListViewController로 이동)
- GPTPackListViewController	GPT로 리스트 생성, 체크/삭제/추가/필터 UI 제공
- AddItemViewController	사용자 커스텀 항목 추가용 (현재는 GPT 화면에 통합됨)
- LoginViewController, SignupViewController	Firebase Auth 연동 예정 로그인·회원가입 화면
- GPTService.swift	OpenAI API 연동 전담 로직 파일
  
💡 UX & UI 특징
- 심플하고 직관적인 인터페이스
- 메인 UI 한 화면 내에서 리스트 확인, 체크, 필터, 추가, 삭제 전부 가능
- 스크롤뷰 적용으로 작은 화면에서도 하단 버튼 누르기 편리
- 자동 줄바꿈 설정된 셀로 긴 항목도 가독성 확보

🌐 향후 확장 계획
- Firebase Authentication 기반 로그인/회원가입 완성
- Firebase Firestore로 사용자 리스트 저장 및 복원
- 테마 변경, 다크모드 대응
- 여행지 자동 위치 추천 연동
 
📸 앱 화면 예시 
- 여행지 & 날짜 입력
- GPT 기반 짐 리스트 생성
- 체크 / 삭제 / 필터링 기능
- 사용자 항목 추가 입력
  
🙋🏻‍♂️ 기대 효과 및 목표
- “여행 전 짐 싸기, 더 이상 고민하지 마세요.”
- PackPalPlus는 사용자가 실제로 여행을 떠나기 전 꼭 챙겨야 할 짐을 AI가 대신 고민해주는 똑똑한 동반자입니다.
- 이 앱을 통해 AI의 실생활 적용 가능성과 사용자 맞춤형 도우미 서비스의 실현 가능성을 입증합니다.
