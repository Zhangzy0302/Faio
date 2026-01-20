//
//  wajfuanvald_whaljf_sign.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//
import SwiftUI

struct WalfuancvaAvajSign: View {
    
    @State private var vajdaUserEmail = ""
    @State private var vajdaPassword = ""
    @State private var vajdaRepassword = ""
    
    @FocusState private var wivnadFocus1: Bool
    @FocusState private var wivnadFocus2: Bool
    @FocusState private var wivnadFocus3: Bool
    
    var body: some View{
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
                        VStack(alignment: .leading, spacing: 12){
                            Text("Password").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
                            BawnbvTextField(placeholder: "Enter password again", text: $vajdaRepassword, isFocused: $wivnadFocus3)
                        }
                    }
                    HStack(){
                        Text("Register").font(.system(size: 14)).foregroundColor(Color(red: 1, green: 235/255, blue: 59/255)).underline()
                        Spacer()
                        Text("Forget pssword").font(.system(size: 14)).foregroundColor(Color(red: 1, green: 141/255, blue: 26/255)).underline()
                    }.frame(maxWidth: .infinity).padding(.top, 30)
                }.padding(.horizontal, 20)
                Spacer()
                FeqocnButton(feqocnText: "Login", action: {}).padding(.horizontal, 20)
            }.frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        }.onTapGesture {
            wivnadFocus1 = false
            wivnadFocus2 = false
            wivnadFocus3 = false
        }
        
    }
}

#Preview {
    WalfuancvaAvajSign()
}
