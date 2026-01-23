import SwiftUI

struct MwaldjReiDaSetting: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    @Binding var appPath: NavigationPath
    
    var body: some View{
        let _ = forceRedraw
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlCenterTitle: "Setting")
                VStack(spacing: 10){
                    MuwcSettingItem(muwcSettingSettingName: "My Gems", muwcIsShowGyms: true, action: {
                        appPath.append(HgywaUserRoute.wallet)
                    })
                    MuwcSettingItem(muwcSettingSettingName: "Privacy Policy", action: {
                        appPath.append(HgywaAppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/privacy"))
                    })
                    MuwcSettingItem(muwcSettingSettingName: "User Agreement", action: {
                        appPath.append(HgywaAppRoute.agreementWeb(webUrl: "https://app.wk3ht8ti.link/users"))
                    })
                    MuwcSettingItem(muwcSettingSettingName: "Blacklist", action: {
                        appPath.append(HgywaUserRoute.userList(listType: .blacklist))
                    })
                }.padding(.top, 20)
                Spacer()
                VStack(spacing: 20){
                    FeqocnButton(feqocnText: "Delete account", feqocnBgColorIsOrange: false, feqocnFontColor: Color(red:1, green: 153/255, blue: 0), action: {})
                    FeqocnButton(feqocnText: "Log out", feqocnBgColorIsOrange: true, action: {
                        appPath.removeLast(appPath.count)
                        appPath.append(HgywaAppRoute.guiding)
                    })
                }.padding(.horizontal, 20).padding(.bottom, 34)
            }
        }.navigationBarHidden(true).enableInjection()
    }
    
    struct MuwcSettingItem: View {
        let muwcSettingSettingName: String
        var muwcIsShowGyms: Bool = false
        var action: () -> Void
        
        var body: some View {
            Button(action: action){
                HStack{
                    Text(muwcSettingSettingName)
                        .font(.system(size: 18))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Spacer()
                    if(muwcIsShowGyms){
                        HStack(spacing: 6){
                            Image("vnzwa_diamond").resizable().frame(width: 20, height: 20)
                            Text("300").font(.system(size: 14)).fontWeight(.medium).foregroundColor(.white)
                        }.padding(.trailing, 12)
                    }
                    
                    Image("vnzwa_icon_arrow_go").resizable().frame(width: 20,height: 20)
                }.padding(.horizontal, 20).padding(.vertical, 10)
            }
        }
    }
}
