import SwiftUI

struct MwaldjReiDaSetting: View {
  @Binding var appPath: NavigationPath

  @EnvironmentObject var userVM: FaioUserViewModel

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar(awicanlCenterTitle: "Setting")
        VStack(spacing: 10) {
          MuwcSettingItem(
            muwcSettingSettingName: "My Gems", muwcIsShowGyms: true,
            muwcGemsCount: userVM.currentUser?.feruyqCawdWalletBalance,
            action: {
              appPath.append(AppRoute.wallet)
            })
          MuwcSettingItem(
            muwcSettingSettingName: "Privacy Policy",
            action: {
              appPath.append(
                AppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/privacy"))
            })
          MuwcSettingItem(
            muwcSettingSettingName: "User Agreement",
            action: {
              appPath.append(AppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/users"))
            })
          MuwcSettingItem(
            muwcSettingSettingName: "Blacklist",
            action: {
              appPath.append(AppRoute.userList(listType: .blacklist))
            })
        }.padding(.top, 20)
        Spacer()
        VStack(spacing: 20) {
          FeqocnButton(
            feqocnText: "Delete account", feqocnBgColorIsOrange: false,
            feqocnFontColor: Color(red: 1, green: 153 / 255, blue: 0),
            action: {
              Task {
                FaioHUD.showLoading()
                await delay(3)
                FaioHUD.hideLoading()
                userVM.deleteAccount()
                appPath.removeLast(appPath.count)
                appPath.append(AppRoute.guiding)
              }
            })
          FeqocnButton(
            feqocnText: "Log out", feqocnBgColorIsOrange: true,
            action: {
              userVM.logout()
              appPath.removeLast(appPath.count)
              appPath.append(AppRoute.guiding)
            })
        }.padding(.horizontal, 20).padding(.bottom, 34)
      }
    }.navigationBarHidden(true)
  }

  struct MuwcSettingItem: View {
    let muwcSettingSettingName: String
    var muwcIsShowGyms: Bool = false
    var muwcGemsCount: Int?
    var action: () -> Void

    var body: some View {
      Button(action: action) {
        HStack {
          Text(muwcSettingSettingName)
            .font(.system(size: 18))
            .fontWeight(.heavy)
            .foregroundColor(.white)
          Spacer()
          if muwcIsShowGyms {
            HStack(spacing: 6) {
              Image("vnzwa_diamond").resizable().frame(width: 20, height: 20)
              Text("\(muwcGemsCount ?? 0)").font(.system(size: 14)).fontWeight(.medium)
                .foregroundColor(.white)
            }.padding(.trailing, 12)
          }

          Image("vnzwa_icon_arrow_go").resizable().frame(width: 20, height: 20)
        }.padding(.horizontal, 20).padding(.vertical, 10)
      }
    }
  }
}
