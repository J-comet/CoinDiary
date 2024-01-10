//
//  LifeCycleModifier.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import SwiftUI

struct LifeCycleModifier: ViewModifier {
    let handler: LifeCycleHandlerProtocol
    func body(content: Content) -> some View {
        content
            .overlay(
                LifeCycleController.Representable(handler: handler)
                    .frame(width: .zero, height: .zero)
            )
    }
}

extension View {
    func lifeCycle(handler: LifeCycleHandlerProtocol) -> some View {
        modifier(LifeCycleModifier(handler: handler))
    }
}
