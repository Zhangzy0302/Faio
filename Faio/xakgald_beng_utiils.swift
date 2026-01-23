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

struct CustomDialog<Content: View>: View {

    @Binding var isPresented: Bool
    let content: Content

    init(isPresented: Binding<Bool>,
         @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        if isPresented {
            ZStack {
                // 背景遮罩
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }

                // 弹框内容
                content
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeOut(duration: 0.25), value: isPresented)
            }
            
        }
    }
}

struct BottomSheet<Content: View>: View {

    @Binding var isPresented: Bool
    let content: Content

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }

                VStack {
                    Spacer()

                    content
                }.animation(.easeOut(duration: 0.25), value: isPresented)
            }
            
        }
    }
}
