//
//  wajfuanvald_whaljf_sign.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//
import SwiftUI

struct WalfuancvaAvajSign: View {
    #if DEBUG
        @ObserveInjection var forceRedraw
  #endif
    
    enum WajfuanType {
        case login
        case register
        case forgot
    }
    
    var vasjawCurrentType: WajfuanType = .login
    
    @State private var vajdaUserEmail = ""
    @State private var vajdaPassword = ""
    @State private var vajdaRepassword = ""
    
    @FocusState private var wivnadFocus1: Bool
    @FocusState private var wivnadFocus2: Bool
    @FocusState private var wivnadFocus3: Bool
    
    @State private var path = NavigationPath()
    @State private var isGoNavPage = false
    
    var body: some View{
        let _ = forceRedraw
        ZStack{
            Color(red: 29/255, green: 29/255, blue: 29/255).ignoresSafeArea()
            
            VStack(alignment: .leading){
                AwicnalWnvTopBar()
                VStack(alignment: .leading){
                    Text("Log In").font(.system(size: 40)).fontWeight(.heavy).foregroundStyle(LinearGradient(colors: [Color.nzcawdMainOrange, Color.nzcawdMainYellow], startPoint: .top, endPoint: .bottom)).padding(.top, 30).padding(.bottom, 40)
                    VStack(spacing: 30){
                        VStack(alignment: .leading, spacing: 12){
                            Text("Email").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
                            BawnbvTextField(placeholder: "Enter email adderss", text: $vajdaUserEmail, isFocused: $wivnadFocus1, keyboardType: .emailAddress)
                        }
                        VStack(alignment: .leading, spacing: 12){
                            Text("Password").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
                            BawnbvTextField(placeholder: "Enter password", text: $vajdaPassword, isFocused: $wivnadFocus2)
                        }
                        if(vasjawCurrentType != .login){
                            VStack(alignment: .leading, spacing: 12){
                                Text("Password").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
                                BawnbvTextField(placeholder: "Enter password again", text: $vajdaRepassword, isFocused: $wivnadFocus3)
                            }
                        }
                    }
                    if(vasjawCurrentType == .login){
                        HStack(){
                            Text("Register").font(.system(size: 14)).foregroundColor(Color(red: 1, green: 235/255, blue: 59/255)).underline()
                            Spacer()
                            Text("Forget pssword").font(.system(size: 14)).foregroundColor(Color(red: 1, green: 141/255, blue: 26/255)).underline()
                        }.frame(maxWidth: .infinity).padding(.top, 30)
                    }
                    
                }.padding(.horizontal, 20)
                Spacer()
                FeqocnButton(feqocnText: "Login", action: {
                    isGoNavPage = true
                }).padding(.horizontal, 20).padding(.bottom, 34)
            }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        }.navigationBarBackButtonHidden(true)  // 隐藏返回按钮
            .toolbar(.hidden, for: .navigationBar) // 隐藏整个导航栏
            .navigationDestination(isPresented: $isGoNavPage, destination: {
                BienajvfjWangrdNavPage()
            })
            .onTapGesture {
            wivnadFocus1 = false
            wivnadFocus2 = false
            wivnadFocus3 = false
        }.enableInjection()
        
    }
}

#Preview {
    WalfuancvaAvajSign()
}
