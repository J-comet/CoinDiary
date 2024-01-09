//
//  CoinDiaryApp.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

@main
struct CoinDiaryApp: App {
    
    var body: some Scene {
        WindowGroup {
            CoinDiaryTabView()
        }
//        .onChange(of: scenePhase) { newScenePhase in
//            switch newScenePhase {
//            case .active:
//                print("App is active")
//                
//            case .inactive:
//                print("App is inactive")
//            case .background:
//                print("App is in background")
//            }
//        }
    }
}
