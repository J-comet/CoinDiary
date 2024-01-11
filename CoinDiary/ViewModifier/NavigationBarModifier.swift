//
//  NavigationBarModifier.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

extension View {
    func navigationBarColor(backgroundColor: UIColor?, titleTextColor: UIColor? = .white) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleTextColor))
    }
}

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    var titleColor: UIColor? = .white
    
    init(backgroundColor: UIColor?, titleColor: UIColor? = .white) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
