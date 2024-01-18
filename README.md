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
<p align="leading" witdh="100%">
<img src="https://github.com/J-comet/CoinZoom/assets/67407666/c338a7ae-ff6d-4c67-a26f-0057a293133f" width="24%">
<img src="https://i.imgur.com/bRV9mzs.gif" width="24%">
<img src="https://i.imgur.com/ucRXsks.gif" width="24%">
</p>

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

<br>

### 트러블슈팅
- WebSocket 연결 및 해제 관리 이슈 <br>
  -> 현재 모든 View 에서 소켓 통신을 하고 있습니다. ViewModel 의 deinit or View 의 onDisappear 내에서 소켓통신 해제를 했더니 다른 View 내에서는 소켓통신이 되지 않았습니다. <br>
  View 가 생성될 때 다시 연결하는 코드를 먼저 작성했었습니다. 하지만 모든 View 가 통신 중이라면 소켓 연결은 유지하되 서버에 원하는 데이터를 재요청하는 것이 관리하기 좋을 것 같다고 판단했습니다. <br>
  Background or Forground 의 상태일 때만 체크 해서 소켓 통신을 연결 해제 하도록 수정했습니다. <br>

<br>

```swift
       ....
            // onChange 앱 생명주기에 따라 소켓 상태 제어
            .onChange(of: scenePhase) { oldValue, newValue in
                switch newValue {
                case .active:
                    WebSocketManager.shared.openWebSocket()
                    viewModel.fetchAllMarket()
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
                    WebSocketManager.shared.closeWebSocket()
                @unknown default:
                    print("error")
                }
            }

```

<br>
  
- 하단 탭 View 전환시 관심 종목 데이터 업데이트 안되는 이슈 <br>
  -> ViewModel 의 init() 구문에서 현재 데이터를 update 해주고 있었습니다. <br>
  그래서 한번만 호출되고 호출되지 않는 문제가 있어 View 가 나타날 때 onAppear 메서드가 실행되는데 데이터를 업데이트 하는 코드를 onAppear 에서 실행하도록 수정했습니다. <br>
  이후 데이터가 잘업데이트 되었지만 학습하면서 task 에 대해 알게되었습니다. <br>
  iOS15 부터는 task 가 새로 등장하였습니다. onAppear 와 다른 점은 비동기통신이 끝나지 않았는데 View 가 종료되는 경우 <br>
  task 쪽에서 실행한 비동기코드를 취소해준다는 장점이 있었습니다. 비동기통신을 다루게 되는 로직은 onAppear 보다는 task 를 사용하는 것이 이점이 있었습니다. <br>
  
  
