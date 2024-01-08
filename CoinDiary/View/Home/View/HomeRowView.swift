//
//  HomeRowView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct HomeRowView: View {
    
    let item: Market
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    
                    VStack {
                        Text(item.english)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.korean)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(width: geometry.size.width / 2.5)
                    
                    Text("현재가")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(width: geometry.size.width / 3.75)
                    
                    Text(item.market)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(width: geometry.size.width / 3.75)
                }
                Spacer()
            }
        }
        .frame(height: 60)
        .padding(.horizontal)
        
    }
    
}

#Preview {
    HomeRowView(item: Market(market: "1", korean: "2", english: "3"))
}
