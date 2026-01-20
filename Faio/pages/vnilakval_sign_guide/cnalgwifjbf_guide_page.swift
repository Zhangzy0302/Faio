//
//  ContentView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct CnalgadGUwjGuidePage: View {
    
    @State private var canalgianw = false;
    
    var body: some View {
        ZStack() {
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

            VStack(){
                Image("vnzwa_app_logo").resizable().frame(width: 85,height: 85).cornerRadius(24).padding(.bottom, 84)
                VStack(spacing: 20){
                    FeqocnButton(feqocnText: "Email", action: {})
                    FeqocnButton(feqocnText: "Tourist", feqocnBgColorIsOrange: false, action: {})
                    
                    HStack{
                        Circle().fill(.white).frame(width: 16, height: 16).overlay(alignment: .center, content: {
                            Circle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow).frame(width: canalgianw ? 10 : 0,height: canalgianw ? 10 : 0)
                        }).onTapGesture {
                            canalgianw = !canalgianw
                        }
                        HStack(){
                            Text("Agree to the ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
                            Text("User Agreement").font(.system(size: 12)).foregroundColor(Color(red: 1, green: 235/255, blue: 59/255)).underline()
                            Text("and ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
                            Text("Privacy Policy").font(.system(size: 12)).foregroundColor(Color(red: 1, green: 141/255, blue: 26/255)).underline()
                        }
                    }

                }
            }.padding(.horizontal, 20).frame(maxHeight: .infinity, alignment: .bottom).padding(.bottom, 60)
                }
    }
}

#Preview {
    CnalgadGUwjGuidePage()
}
