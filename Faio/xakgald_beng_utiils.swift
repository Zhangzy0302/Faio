//
//  File.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func readBottomSafeArea(_ onChange: @escaping (CGFloat) -> Void) -> some View {
            background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            onChange(geo.safeAreaInsets.bottom)
                        }
                }
            )
        }
}
