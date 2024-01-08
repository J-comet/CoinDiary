//
//  HomeHeaderView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
            VStack {
                Spacer()
                Text("실시간 코인 정보")
                    .fontWeight(.bold)
                Spacer()
                Divider()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 56)
            .background(Rectangle().foregroundStyle(.white))
        }
}

#Preview {
    HomeHeaderView()
}
