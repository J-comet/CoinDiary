//
//  DetailCoinView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import SwiftUI

struct DetailCoinView: View {
    
    @StateObject
    var viewModel: DetailViewModel
    
    init(coin: HomeCoinRow) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("차트 생길 곳")
                        .frame(height: 400)
                        .background(.yellow)
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(viewModel.coin.market.english)
                                    .font(.title3)
                                    .bold()
                                
                                Text("(\(viewModel.coin.market.market))")
                                    .font(.caption)
                                    .foregroundStyle(Color(.lightGray))
                            }
                            
                            Text(viewModel.coin.ticker.tradePriceValue)
                                .font(.title2)
                                .bold()
                                .foregroundStyle(
                                    viewModel.coin.ticker.isBid ? Color(hex: "ed2939") : Color(hex: "1560bd")
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(viewModel.coin.ticker.isTradingSuspended ? .orange : .green)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
                            
                            Text(viewModel.coin.ticker.isTradingDiscription)
                                .bold()
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    
                    Divider()
                    
                    LazyVGrid(columns: columns,
                              alignment: .leading,
                              spacing: spacing,
                              pinnedViews: [],
                              content: {
                        
                        ForEach(viewModel.detailInfos, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.lightGray))
                                
                                Text(item.value)
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color(hex: item.askOrBidColor))
                            }
                        }
                        
                    })

                }
                .toolbar {
    //                ToolbarItemGroup(placement: .topBarLeading) {
    //                    Button {
    //                        showChart.toggle()
    //                    } label: {
    //                        Image(systemName: "star.fill")
    //                    }
    //                }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            print("클릭되었습니다!")
                        } label: {
                            Image(systemName: "bookmark")
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.coin.market.korean)
            .navigationBarBackButtonTitleHidden()
        }
        
        
        
        
        
    }
}

#Preview {
    DetailCoinView(coin: HomeCoinRow(market: Market(market: "마켓", korean: "한국어", english: "영어")))
}
