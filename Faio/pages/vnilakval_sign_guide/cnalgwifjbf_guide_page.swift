//
//  ContentView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct CnalgadGUwjGuidePage: View {
    #if DEBUG
        @ObserveInjection var forceRedraw
      #endif

    @State private var canalgianw = false;
    
    @AppStorage("isAgree") var isAgree = false
    @State private var wcvnanGoToSign: Bool = false
    
    var body: some View {
        let _ = forceRedraw
        NavigationStack{
            ZStack() {
                Image("vnzwa_guide_bg")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 29/255, green: 29/255, blue: 29/255), Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                ).ignoresSafeArea()

                VStack(){
                    Image("vnzwa_app_logo").resizable().frame(width: 85,height: 85).cornerRadius(24).padding(.bottom, 84)
                    VStack(spacing: 20){
                        FeqocnButton(feqocnText: "Email", action: {
                            if(isAgree){
                                wcvnanGoToSign = true
                            }else{
                                print("please")
                            }
                        })
                        
                        FeqocnButton(feqocnText: "Tourist", feqocnBgColorIsOrange: false, action: {})
                        
                        HStack{
                            Circle().fill(.white).frame(width: 16, height: 16)
                                .overlay(alignment: .center, content: {
                                    Circle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                                        .frame(width: 10,height: 10)
                                        .scaleEffect(isAgree ? 1 : 0)
                                        .animation(.easeOut(duration: 0.2), value: isAgree)
                            }).onTapGesture {
                                isAgree.toggle()
                            }
                            HStack(){
                                Text("Agree to the ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
                                Text("User Agreement").font(.system(size: 12)).foregroundColor(Color(red: 1, green: 235/255, blue: 59/255)).underline()
                                Text("and ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
                                Text("Privacy Policy").font(.system(size: 12)).foregroundColor(Color(red: 1, green: 141/255, blue: 26/255)).underline()
                            }
                        }

                    }
                }.padding(.horizontal, 20).padding(.bottom, 60).frame(maxHeight: .infinity, alignment: .bottom)
            }.navigationDestination(isPresented: $wcvnanGoToSign) {
                WalfuancvaAvajSign()
            }.navigationBarHidden(true).toolbar(.hidden, for: .navigationBar)
        }.enableInjection()
    }
}

#Preview {
    CnalgadGUwjGuidePage()
}
