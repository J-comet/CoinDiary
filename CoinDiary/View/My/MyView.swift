//
//  MyView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct MyView: View {
    
    @State
    private var bookmarkCoins: [BookmarkCoin] = [
        BookmarkCoin(lang: "English"),
        BookmarkCoin(lang: "11111111"),
        BookmarkCoin(lang: "23232323"),
        BookmarkCoin(lang: "1010"),
        BookmarkCoin(lang: "5495959"),
        BookmarkCoin(lang: "1923929"),
        BookmarkCoin(lang: "123"),
    ]
    
    private var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    @State
    private var selectedBookmarkCoins: [BookmarkCoin] = []
    
    @Namespace var namespace
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                if !bookmarkCoins.isEmpty {
                    HStack {
                        Text("매도 코인")
                            .font(.title3)
                            .bold()
                            .frame(width: 100, height: 50)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                    .fill(Color.init(hex: "1560bd").gradient.opacity(0.5))
                            }
                            .foregroundColor(.white)

                        Spacer()
                    }
                    .padding()
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        
                        ForEach(bookmarkCoins) { coin in
                            Text(coin.lang)
                                .foregroundStyle(.white)
                                .lineLimit(2)
                                .bold()
                                .frame(width: 100, height: 100)
                                .background(.blue)
                                .cornerRadius(15)
                                .matchedGeometryEffect(id: coin.id, in: self.namespace)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        // 이동 시키기
                                        selectedBookmarkCoins.append(coin)
                                        // 기존 아이템 제거
                                        bookmarkCoins.removeAll { $0.id == coin.id }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Text("매수 코인")
                        .font(.title3)
                        .bold()
                        .frame(width: 100, height: 50)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                .fill(Color.init(hex: "ed2939").gradient.opacity(0.5))
                        }
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                LazyVGrid(columns: columns, spacing: 15) {
                    
                    ForEach(selectedBookmarkCoins) { coin in
                        Text(coin.lang)
                            .foregroundStyle(.white)
                            .lineLimit(2)
                            .bold()
                            .frame(width: 100, height: 100)
                            .background(Color.init(hex: "ed2939"))
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: coin.id, in: self.namespace)
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    // 다시 보내기
                                    bookmarkCoins.append(coin)
                                    selectedBookmarkCoins.removeAll { $0.id == coin.id }
                                }
                            }
                        
                    }
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("관심 종목")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MyView()
}
