# CoinZoom

### 프로젝트
 - 인원 : 개인프로젝트 <br>
 - 기간 : 2023.1.6 ~ 2023.1.12 (1주) <br>
 - 최소지원버전 : iOS 17 <br>
 
<br>

### 한줄소개
 - 실시간 코인 정보를 차트를 통해 쉽게 확인 가능하며 관심 종목을 저장할 수 있는 앱 입니다.

<br>

### 미리보기


<br>

### 기술
| Category | Stack |
|:----:|:-----:|
| Architecture | `MVVM` |
|  UI  | `SwiftUI` |
| Reactive | `Combine` |
| iOS | `Charts` `UserDefaults` |
|  Network  | `URLSessionWebSocketTask` |

<br>

### API
- Upbit API

<br>

### 기능
- 실시간 코인 정보를 확인할 수 있습니다.
- 차트를 통해 실시간 변동하는 코인 금액을 확인할 수 있습니다.
- 관심있는 종목을 따로 저장할 수 있습니다.

<br>

### 개발 고려사항
- 웹소켓이 특정 시점에 메모리에서 해제되도록 관리
- 서버에 의해 웹소켓통신이 끊이지 않도록 Ping 을 주기적으로 Upbit 서버에 전송
- 실시간으로 전달 받는 코인 데이터를 유저에게 쉽게 파악할 수 있는 차트 정보 제공
- LazyVStack 의 pinnedViews 를 활용해 Sticky Header 구현
- 재사용성을 고려해 ViewModifier 프로토콜을 채택한 CustomModifier 구현 
- 관심종목의 북마크 데이터 동기화

### 트러블슈팅
- WebSocket 연결 및 해제 관리
  ...
  
- 상세페이지에서 돌아왔을 때 관심종목 List 업데이트 되지 않는 오류
  ...
