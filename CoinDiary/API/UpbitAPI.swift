//
//  UpbitAPI.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case requestFailed
    case invalidResponse
    case decodingError
}

struct UpbitAPI {
    private init() { }
    
    static func fetchMarket() -> AnyPublisher<[Market], Error> {
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else {
            return Fail(error: NetworkError.requestFailed).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: [Market].self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
