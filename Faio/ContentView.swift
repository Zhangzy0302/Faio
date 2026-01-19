//
//  ContentView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
                    Image("vnzwa_guide_bg")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()   // 关键：铺满整页
                        // 黑色渐变遮罩
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 29/255, green: 29/255, blue: 29/255), Color.black.opacity(0)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .ignoresSafeArea()

            VStack{
                Image("vnzwa_app_logo").resizable().frame(width: 85,height: 85).cornerRadius(24)
                VStack{
                    Button(PrimitiveButtonStyleConfiguration).frame(maxWidth: .infinity)
                }
            }
                }
    }
}

#Preview {
    ContentView()
}
