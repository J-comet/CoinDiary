//
//  UIApplication.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import UIKit

extension UIApplication {
    func currentUIWindow() -> UIWindow? {
           let connectedScenes = UIApplication.shared.connectedScenes
               .filter { $0.activationState == .foregroundActive }
               .compactMap { $0 as? UIWindowScene }
           let window = connectedScenes.first?
               .windows
               .first { $0.isKeyWindow }
           return window
       }
}
