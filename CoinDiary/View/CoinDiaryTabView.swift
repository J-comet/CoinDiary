//
//  CoinDiaryTabView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct CoinDiaryTabView: View {
    
    @State private var selectedTab: TabType = TabType.home
    
    var body: some View {
        // 해당 탭 태그 설정후 태그로 어떤 탭인지 구분
        TabView(selection: $selectedTab) {            
            HomeView()
                .tabItem { Image(systemName: "house") }
                .tag(TabType.home)
            MyView()
                .tabItem { Image(systemName: "square.and.pencil") }
                .tag(TabType.my)
        }
        // 위젯 관련
//        .onOpenURL(perform: { url in
//            switch url.absoluteString {
//            case "History": selectedTab = "book"
//            case "Favorite": selectedTab = "favorite"
//            default: selectedTab = "pencil"
//            }
//        })
    }
}

enum TabType: String {
    case home
    case my
}

#Preview {
    CoinDiaryTabView()
}
