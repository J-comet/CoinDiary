//
//  WebSocketManager.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation
import Combine

final class WebSocketManager: NSObject {
    static let shared = WebSocketManager()
    
    // NSObject 에서 public 함수로 init 함수가 있기 때문에 override 필요
    override init() {
        super.init()
    }
    
    private var timer: Timer?  // 5초마다 ping 을 하기위해 생성
    private var webSocket: URLSessionWebSocketTask?
    
    private var isOpen = false
    
    
    /**
     1. RxSwift PublishSubject vs Combine PassthroughSubject
     2. RxSwift BehaviorSubject vs Combine CurrentValueSubject
     3. RxSwift 데이터 타입만 설정 vs Combine 데이터 타입 + 오류 타입 함께 지정
     */
    var coinTickerSbj = PassthroughSubject<CoinTicker, Never>()
    
    func openWebSocket() {
        if !isOpen {
            if let url = URL(string: "wss://api.upbit.com/websocket/v1") {
                let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
                webSocket = session.webSocketTask(with: url)
                webSocket?.resume()
                ping()
            }
        }
    }
    
    func closeWebSocket() {
        // URLSessionWebSocketTask Enum Close Code = goingAway
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
        
        timer?.invalidate()
        timer = nil
        
        isOpen = false
    }
    
    func send(marketCodes: [String]) {
        
        let codeDict: [String: [String]] = ["codes": marketCodes]
        let strCodeDict = String(describing: codeDict).dropFirst().dropLast()
        print("result = ", strCodeDict)
        
        // Test Data
        let tickerTestData = """
      [
        {
          "ticket": "test example"
        },
        {
          "type": "ticker",
            \(strCodeDict)
        },
        {
          "format": "DEFAULT"
        }
      ]
"""
        
//        let jsonData = try! JSONEncoder().encode(request)
//        let jsonString = String(data: jsonData, encoding: .utf8)!
//        print("jsonString = ", jsonString)
                
        webSocket?.send(.string(tickerTestData), completionHandler: { error in
            if let error {
                print("send error = \(error.localizedDescription)")
            }
        })
    }
    
    func receive() {
        if isOpen {
            webSocket?.receive(completionHandler: { [weak self] result in
                switch result {
                case .success(let success):
//                    print("success = ", success)
                    switch success {
                    case .data(let data):
                        if let decodedData = try? JSONDecoder().decode(CoinTicker.self, from: data) {
                            print("receive = ", decodedData)
                            // RxSwift onNext vs Combine send
                            self?.coinTickerSbj.send(decodedData)
                        }
                    case .string(let string):
                        print(string)
                    @unknown default:
                        print("unknown")
                    }
                    
                case .failure(let failure):
                    print("failure = ", failure)
                    self?.closeWebSocket()
                }
                
                self?.receive()  // 재귀방식으로 receive 해두어야 지속적으로 통신 가능
            })
        }
    }
    
    // 서버에 의해 연결이 끊어지지 않도록 주기적으로 Ping 을 서버에 보냄
    private func ping() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { [weak self] _ in
            self?.webSocket?.sendPing(pongReceiveHandler: { error in
                if let error {
                    print("Ping Error = ", error.localizedDescription)
                } else {
                    print("Ping")
                }
            })
        })
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    // didOpen: 웹소켓 연결되었는지 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocketManager Open")
        isOpen = true
        receive()
    }
    
    // didClose: 웹소켓 연결 해제되었는지 확인
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocketManager Close")
    }
}
