//
//  HomeHeaderView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    
                    Text("코인명")
                        .font(.subheadline)
                        .foregroundStyle(.gray)                    
                        .frame(width: geometry.size.width / 2.5, alignment: .leading)
                    
                    Text("현재가")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(width: geometry.size.width / 3.75)
                    
                    Text("거래대금")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(width: geometry.size.width / 3.75)
                }
                Spacer()
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
        .background(Color(uiColor: .systemGray6))
        
    }
}

#Preview {
    HomeHeaderView()
}
