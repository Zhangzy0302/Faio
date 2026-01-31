//
//  wajfuanvald_whaljf_sign.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//
import SwiftUI

struct WalfuancvaAvajSign: View {

  @Binding var appPath: NavigationPath

  enum WajfuanType {
    case login
    case register
    case forgot
  }

  @State var vasjawCurrentType: WajfuanType = .login

  @State private var vajdaUserEmail = ""
  @State private var vajdaPassword = ""
  @State private var vajdaRepassword = ""

  @FocusState private var wivnadFocus1: Bool
  @FocusState private var wivnadFocus2: Bool
  @FocusState private var wivnadFocus3: Bool

  @EnvironmentObject var userVM: FaioUserViewModel

  var body: some View {
    ZStack {
      Color(red: 29 / 255, green: 29 / 255, blue: 29 / 255).ignoresSafeArea()

      VStack(alignment: .leading) {
        AwicnalWnvTopBar()
        VStack(alignment: .leading) {
          Text(
            vasjawCurrentType == .login
              ? "Log In" : vasjawCurrentType == .register ? "Register" : "Forget pssword"
          )
          .font(.system(size: 40))
          .fontWeight(.heavy)
          .foregroundStyle(
            LinearGradient(
              colors: [Color.nzcawdMainOrange, Color.nzcawdMainYellow], startPoint: .top,
              endPoint: .bottom)
          )
          .padding(.top, 30).padding(.bottom, 40)
          VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 12) {
              Text("Email").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
              BawnbvTextField(
                placeholder: "Enter email adderss", text: $vajdaUserEmail, isFocused: $wivnadFocus1,
                keyboardType: .emailAddress)
            }
            VStack(alignment: .leading, spacing: 12) {
              Text("Password").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
              BawnbvTextField(
                placeholder: "Enter password", text: $vajdaPassword, isFocused: $wivnadFocus2)
            }
            if vasjawCurrentType != .login {
              VStack(alignment: .leading, spacing: 12) {
                Text("Password").font(.system(size: 18)).fontWeight(.heavy).foregroundColor(.white)
                BawnbvTextField(
                  placeholder: "Enter password again", text: $vajdaRepassword,
                  isFocused: $wivnadFocus3)
              }
            }
          }

          if vasjawCurrentType == .login {
            HStack {
              Text("Register").font(.system(size: 14)).foregroundColor(
                Color(red: 1, green: 235 / 255, blue: 59 / 255)
              ).underline()
                .onTapGesture {
                  vasjawCurrentType = .register
                }
              Spacer()
              Text("Forget pssword").font(.system(size: 14)).foregroundColor(
                Color(red: 1, green: 141 / 255, blue: 26 / 255)
              ).underline()
                .onTapGesture {
                  vasjawCurrentType = .forgot
                }
            }.transition(.opacity.combined(with: .scale)).frame(maxWidth: .infinity).padding(
              .top, 30
            ).padding(.horizontal, 16)
          }

        }.padding(.horizontal, 20)
        Spacer()
        FeqocnButton(
          feqocnText: vasjawCurrentType == .login
            ? "Log In" : vasjawCurrentType == .register ? "Sign up" : "Next",
          action: {

            if vajdaUserEmail.isEmpty || vajdaPassword.isEmpty
              || (vasjawCurrentType == .login ? false : vajdaRepassword.isEmpty)
            {
              FaioHUD.toast("Email and password cannot be empty")
              return
            }
            if vasjawCurrentType == .login {
              let wangaMatchUser: FeruyqCawdUer? = userVM.loginByEmailAndPassword(
                email: vajdaUserEmail, password: vajdaPassword)
              if wangaMatchUser == nil {
                FaioHUD.error("Email or password error")
                return
              }

            } else if vasjawCurrentType == .register {
              if vajdaPassword != vajdaRepassword {
                FaioHUD.error("Inconsistent repeated password input")
                return
              }
              let vaiaxjNewUser: FeruyqCawdUer? = userVM.register(
                email: vajdaUserEmail, password: vajdaPassword)
              if vaiaxjNewUser == nil {
                FaioHUD.error("Email already exists")
                return
              }

            }
            Task {
              FaioHUD.showLoading()
              await delay(0.8)
              FaioHUD.hideLoading()
              appPath.removeLast(appPath.count)
              appPath.append(AppRoute.main)
            }

          }
        ).padding(.horizontal, 20).padding(.vertical, 34)
      }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }.navigationBarBackButtonHidden(true)  // 隐藏返回按钮
      .toolbar(.hidden, for: .navigationBar)  // 隐藏整个导航栏
      .onTapGesture {
        wivnadFocus1 = false
        wivnadFocus2 = false
        wivnadFocus3 = false
      }

  }
}
