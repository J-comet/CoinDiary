//
//  UserDefaultData.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import Foundation

@propertyWrapper
struct UserDefaultData<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct UserDefaultStruct<T> where T: Codable {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data,
                  let decodedData = try? PropertyListDecoder().decode(T.self, from: data)
            else { return defaultValue }
            return decodedData
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: key)
        }
    }
}

enum UserDefaultsKey: String {
    case bookmarkCoins
}

extension UserDefaults {
    
    @UserDefaultStruct(key: UserDefaultsKey.bookmarkCoins.rawValue, defaultValue: [])
    static var bookmarkCoins: [HomeCoinRow]

}
