//
//  MyCoinView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

struct MyCoinView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.2).ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 20, content: {
                        ForEach(1...10, id: \.self) { count in
                            MyCoinRowView()
                                .padding(.horizontal, 8)
                        }
                    })
                    .padding(.top, 16)
                }
                .navigationTitle("관심 종목")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(backgroundColor: .white, titleTextColor: .black)
            }
            .padding(.bottom, 1)
        }
        
    }
}

#Preview {
    MyCoinView()
}
