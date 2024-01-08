//
//  HomeViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
//    @Published var markets: [Market] = []
    
    @Published var markets: [Market] = [
        Market(market: "aaa1", korean: "ㄴㄴㄴ", english: "ssss"),
        Market(market: "aaa2", korean: "ㄴㄴㄴ", english: "ssss"),
        Market(market: "aaa3", korean: "ㄴㄴㄴ", english: "ssss"),
        Market(market: "aaa4", korean: "ㄴㄴㄴ", english: "ssss"),
        Market(market: "aaa5", korean: "ㄴㄴㄴ", english: "ssss")
    ]
    
    func combineFetchAllMarket() {
        
    }
    
    func fetchAllMarket() {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터 없음")
                return
            }
            
            // do try catch 를 사용했을 때 에러를 확인할 수 있음.
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.markets = decodedData
//                    completionHandler(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
