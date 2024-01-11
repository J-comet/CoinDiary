//
//  MyCoinView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

struct MyCoinView: View {
    
    @StateObject var viewModel = MyCoinViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if viewModel.myCoinTickers.isEmpty {
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Text("관심있는 종목을 저장해주세요")
                                .font(.title3)
                                .foregroundStyle(Color(.lightGray))
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVStack(spacing: 20, content: {
                            ForEach(viewModel.myCoinTickers, id: \.market.market) { item in
                                
                                NavigationLink(destination: DetailCoinView(coin: item)) {
                                    MyCoinRowView(item: item)
                                        .background {
                                            RoundedRectangle(cornerRadius: 6, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                                .fill(.white.shadow(.drop(radius: 1)))
                                        }
                                        .padding(.horizontal, 8)
                                        .onAppear {
                                            print("북마크 코인뷰 onAppear")
                                            viewModel.fetchMarket()
                                        }
                                    
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        })
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
            .navigationTitle("관심 종목")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: .white, titleTextColor: .black)
        }
        .lifeCycle(handler: viewModel)
    }
}

#Preview {
    MyCoinView()
}
