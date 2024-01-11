//
//  MyCoinRowView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

struct MyCoinRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Spacer()
                HStack(spacing: 6) {
                    Text("영어 코인명")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Text("한글 코인명")
                        .font(.caption)
                    
                    Spacer()
                    
                    Image(systemName: "bookmark.fill")
                        .foregroundStyle(Color.init(hex: "1560bd"))
                }
                Spacer()
            }
            .padding(.horizontal, 12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("현재가")
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                
                HStack {
                    Text("591,402,122,231,1223")
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
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 8,
                    bottomTrailingRadius: 8,
                    topTrailingRadius: 0
                )
            )
        }
        .frame(height: 150)
        .background {
            RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .fill(Color(.systemGray6))
        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MyCoinRowView()
}
