//
//  bienajvfj_wangrd_nav_page.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

struct BienajvfjWangrdNavPage: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    @State var awncalCurrentPageIndex: Int = 1
    
    func page(for index: Int) -> AnyView {
        switch index {
        case 0: return AnyView(EiwnbMessagePage())
        case 1: return AnyView(NwuivalNwiHome())
        default: return AnyView(HgrunclMinePage())
        }
    }
    
    var body: some View {
        let _ = forceRedraw
        NavigationStack{
            ZStack(alignment: .bottom){
                VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
                page(for: awncalCurrentPageIndex)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                HStack{
                    HStack{
                        bineanNavIcon(bienaIcon: "vnzwa_nav_chat", bienaNavIndex: 0, beinaCurrentIndex: $awncalCurrentPageIndex)
                        bineanNavIcon(bienaIcon: "vnzwa_nav_home", bienaNavIndex: 1, beinaCurrentIndex: $awncalCurrentPageIndex)
                        bineanNavIcon(bienaIcon: "vnzwa_nav_mine", bienaNavIndex: 2, beinaCurrentIndex: $awncalCurrentPageIndex)
                    }.padding(.horizontal,10).frame(width: 225, height: 56)
                        .background(RoundedRectangle(cornerRadius: 100).fill(Color(red: 19/255, green: 19/255,blue: 19/255)))
                    Spacer()
                    Circle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                        .frame(width: 54)
                        .overlay(content: {
                            Image("vnzwa_icon_add").resizable().frame(width: 20,height: 20)
                        })
                        
                }.frame(width: .infinity, height: 56, alignment: .bottom)
                    .padding(.horizontal, 20).padding(.bottom, 10)
            }.navigationBarHidden(true).toolbar(.hidden, for: .navigationBar)
        }.enableInjection()
    }
    
    struct bineanNavIcon: View {
        let bienaIcon: String
        let bienaNavIndex: Int
        @Binding var beinaCurrentIndex: Int
        
        var body: some View{
            VStack{
                Image(bienaNavIndex == beinaCurrentIndex ? bienaIcon : "\(bienaIcon)_un").resizable().frame(width: 29, height: 29)
                    
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.2), {beinaCurrentIndex = bienaNavIndex})
            }
        }
    }
}

#Preview {
    BienajvfjWangrdNavPage()
}
