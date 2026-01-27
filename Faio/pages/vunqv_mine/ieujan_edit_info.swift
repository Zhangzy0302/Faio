import SwiftUI

struct IeujanEditInfo: View {
    @State private var ieujanUserName: String = ""
    @State private var ieujanAboutMe: String = ""
    
    @FocusState private var ieujanNameFocus: Bool
    @FocusState private var ieujanAboutMeFocus: Bool
    
    @State private var ieujanMyAvatar: String = "vnzwa_default_avatar"
    
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlCenterTitle: "Edit")
                VStack{
                    ZStack(alignment: .bottomTrailing){
                        Circle().frame(width: 135, height: 135)
                            .overlay(content: {
                                ZwnagIreujImage(zwnagIreujImageUrl: ieujanMyAvatar,
                                                zwnagIreujWidth: 135, zwnagIreujHeight: 135, zwnagIreujIsCircle: true)
                            })
                        Image("vnzwa_change_avatar").resizable().frame(width: 40,height: 40)
                    }.frame(width: 135, height: 135)
                        .padding(.top, 30).padding(.bottom, 24)
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text("Name")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        BawnbvTextField(placeholder: "Please enter", text: $ieujanUserName, isFocused: $ieujanNameFocus)
                    }.padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 12){
                        Text("About Me")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        BawnbvTextField(placeholder: "Please enter", text: $ieujanAboutMe, isFocused: $ieujanAboutMeFocus, height: 128)
                    }
                    Spacer()
                    FeqocnButton(feqocnText: "Save", action: {}).padding(.vertical, 20)
                }
            }.padding()
        }.navigationBarHidden(true).onTapGesture {
            ieujanNameFocus = false
            ieujanAboutMeFocus = false
        }.onAppear{
            ieujanUserName = userVM.currentUser?.feruyqCawdUserName ?? ""
            ieujanAboutMe = userVM.currentUser?.feruyqCawdAboutMe ?? ""
            ieujanMyAvatar = userVM.currentUser?.feruyqCawdAvatar ?? "vnzwa_default_avatar"
        }
    }
}

#Preview {
    IeujanEditInfo()
}
