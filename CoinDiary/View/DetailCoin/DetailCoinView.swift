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
    
    var body: some View {
        ZStack {
            NavigationView {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle(viewModel.coin.market.korean)
            .navigationBarBackButtonTitleHidden()
            
        }
        
    }
}

#Preview {
    DetailCoinView(coin: HomeCoinRow(market: Market(market: "", korean: "", english: "")))
}
