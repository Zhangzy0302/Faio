//
//  ContentView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct CnalgadGUwjGuidePage: View {
  @Binding var canlAuthPath: NavigationPath

  @State private var canalgianw = false

  @State private var wcvnanGoToSign: Bool = false

  @EnvironmentObject var userVM: FaioUserViewModel

  @StateObject private var viewModel = MelodyMateInitViewModel()
  @StateObject private var locationManager = XmaalwiDAiLocationManager.shared

  var body: some View {
    ZStack {
      GeometryReader { geo in
        Image("vnzwa_guide_bg")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
      }

      LinearGradient(
        gradient: Gradient(colors: [
          Color(red: 29 / 255, green: 29 / 255, blue: 29 / 255), Color.black.opacity(0),
        ]),
        startPoint: .bottom,
        endPoint: .top
      ).ignoresSafeArea()

      VStack {
        Image("vnzwa_app_logo").resizable().frame(width: 85, height: 85).cornerRadius(24).padding(
          .bottom, 84)
        switch viewModel.waknxaPaksStatus {
        case .loading:
          VStack(spacing: 40) {
            ProgressView()
              .progressViewStyle(.circular)
              .scaleEffect(1.4)
              .tint(.white)

            Text("Loading...")
              .font(.system(size: 12))
              .foregroundColor(.white)
          }
        case .xmaalwiDAiB:
          FeqocnButton(
            feqocnText: "Quick Login",
            action: {
              Task {
                viewModel.waknxaPaksStatus = .loading
                if let route = await WyneBassUnionInitUtils.shared.waknxaPaksGoLogin() {

                  await MainActor.run {
                    canlAuthPath.removeLast(canlAuthPath.count)
                    canlAuthPath.append(route)
                  }
                }
                viewModel.waknxaPaksStatus = .xmaalwiDAiB
              }

            })

        case .xmaalwiDAiA:
          CnauwlMZuwqoGuideToA(canlAuthPath: $canlAuthPath)
        }
      }.padding(.horizontal, 20).padding(.bottom, 60).frame(
        maxHeight: .infinity, alignment: .bottom)
      CustomDialog(isPresented: $locationManager.showLocationDialog) {
        EtzbzaLocationDailog(pwovzaIsShowAlert: $locationManager.showLocationDialog)
      }
    }.navigationBarHidden(true)
      .onAppear {
        Task {
          await viewModel.waknxaPaksInitFlow()
        }
      }.onChange(of: viewModel.nextRoute) { route in
        if let route = route {
          canlAuthPath.append(route)
          viewModel.nextRoute = nil  // 防止重复跳转
        }
      }
  }

  struct CnauwlMZuwqoGuideToA: View {
    @Binding var canlAuthPath: NavigationPath
    @AppStorage("isAgree") var isAgree = false
    @EnvironmentObject var userVM: FaioUserViewModel

    var body: some View {
      VStack(spacing: 20) {
        FeqocnButton(
          feqocnText: "Email",
          action: {
            if isAgree {
              canlAuthPath.append(AppRoute.sign)
            } else {
              FaioHUD.toast("Please read and agree to the agreement first")
            }
          })

        FeqocnButton(
          feqocnText: "Tourist", feqocnBgColorIsOrange: false,
          action: {
            if isAgree {

              Task {
                userVM.visitorLogin()
                FaioHUD.showLoading()
                await delay(0.8)
                FaioHUD.hideLoading()
                canlAuthPath.removeLast(canlAuthPath.count)
              }
            } else {
              FaioHUD.toast("Please read and agree to the agreement first")
            }
          })

        HStack {
          Circle().fill(.white).frame(width: 16, height: 16)
            .overlay(
              alignment: .center,
              content: {
                Circle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                  .frame(width: 10, height: 10)
                  .scaleEffect(isAgree ? 1 : 0)
                  .animation(.easeOut(duration: 0.2), value: isAgree)
              }
            ).onTapGesture {
              isAgree.toggle()
            }
          HStack {
            Text("Agree to the ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
            Text("User Agreement").font(.system(size: 12)).foregroundColor(
              Color(red: 1, green: 235 / 255, blue: 59 / 255)
            ).underline()
              .onTapGesture {
                canlAuthPath.append(
                  AppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/users"))
              }
            Text("and ").font(.system(size: 12)).foregroundColor(.white.opacity(0.5))
            Text("Privacy Policy").font(.system(size: 12)).foregroundColor(
              Color(red: 1, green: 141 / 255, blue: 26 / 255)
            ).underline()
              .onTapGesture {
                canlAuthPath.append(
                  AppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/privacy"))
              }
          }
        }

      }
    }
  }
}
