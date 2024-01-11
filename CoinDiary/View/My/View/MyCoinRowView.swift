//
//  MyCoinRowView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

struct MyCoinRowView: View {
    
    let item: HomeCoinRow
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Spacer()
                HStack(spacing: 6) {
                    Text(item.market.english)
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Text(item.market.korean)
                        .font(.caption)
                    
                    Spacer()
                    
                    Image(systemName: "bookmark.fill")
                        .foregroundStyle(Color.init(hex: "1560bd"))
                }
                Spacer()
            }
            .padding(.horizontal, 12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("전일 대비")
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                
                HStack {
                    Text("\(item.ticker.changePrice)")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text("상세정보")
                        .font(.callout)
                    Image(systemName: "arrow.right")
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 100)
            .background(.white)
//            .clipShape(
//                .rect(
//                    topLeadingRadius: 0,
//                    bottomLeadingRadius: 8,
//                    bottomTrailingRadius: 8,
//                    topTrailingRadius: 0
//                )
//            )
        }
        .frame(height: 150)
        .background(Color(.systemGray6))
//        .background {
//            RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
//                .fill(Color(.systemGray6))
//        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MyCoinRowView(
        item: HomeCoinRow(
            market: Market(market: "", korean: "korean", english: "english"),
            ticker: CoinTicker.EmptyTicker())
    )
}
