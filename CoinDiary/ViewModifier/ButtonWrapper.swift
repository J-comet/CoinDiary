//
//  ButtonWrapper.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button(
            action: action,
            label: {
            content
        })
        .buttonStyle(.plain)
    }
    
}

extension View {
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}
