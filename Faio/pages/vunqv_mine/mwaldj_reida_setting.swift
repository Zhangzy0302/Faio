import SwiftUI

struct MwaldjReiDaSetting: View {
    var body: some View{
        NavigationStack{
            ZStack(alignment: .top){
                VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
                VStack{
                    AwicnalWnvTopBar(awicanlCenterTitle: "Setting")
                    VStack(spacing: 10){
                        MuwcSettingItem(muwcSettingSettingName: "My Gems", muwcIsShowGyms: true)
                        MuwcSettingItem(muwcSettingSettingName: "Privacy Policy")
                        MuwcSettingItem(muwcSettingSettingName: "User Agreement")
                        MuwcSettingItem(muwcSettingSettingName: "Blacklist")
                    }.padding(.top, 20)
                    Spacer()
                    VStack(spacing: 20){
                        FeqocnButton(feqocnText: "Delete account", feqocnBgColorIsOrange: false, action: {})
                        FeqocnButton(feqocnText: "Log out", feqocnBgColorIsOrange: true, action: {})
                    }.padding(.horizontal, 20).padding(.bottom, 34)
                }
            }
        }.navigationBarHidden(true)
    }
    
    struct MuwcSettingItem: View {
        let muwcSettingSettingName: String
        var muwcIsShowGyms: Bool = false
        
        var body: some View {
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

#Preview {
    MwaldjReiDaSetting()
}
