//
//  HomeRowView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct HomeRowView: View {
    
    let item: HomeCoinRow
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    
                    VStack {
                        Text(item.market.english)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.market.korean)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(width: geometry.size.width / 2.5)
                    
                    Text("\(item.ticker.tradePriceValue)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(width: geometry.size.width / 3.75)
                    
                    Text("\(item.ticker.accTradePriceValue)")
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
    HomeRowView(item: 
                   HomeCoinRow(market: Market(market: "market", korean: "korean", english: "english"))
    )
}
