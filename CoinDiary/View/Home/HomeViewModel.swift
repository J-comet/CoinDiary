//
//  HomeViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var markets: [Market] = []
    var cancellables = Set<AnyCancellable>()
    
    func combineFetchAllMarket() {
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Market].self, decoder: JSONDecoder())
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] markets in
                self?.markets = markets
            }
            .store(in: &cancellables)
    }
    
}
