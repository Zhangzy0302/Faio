import SwiftUI

struct VwaldjgVideoCalling: View {
    let vwaljdChatUserId: Int
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack {
            if let vwalUserInfo = userVM.userInfo {
                ZwnagIreujImage(zwnagIreujImageUrl: vwalUserInfo.feruyqCawdAvatar, zwnagIreujWidth: .infinity, zwnagIreujHeight: .infinity).ignoresSafeArea()
            }
            Rectangle().fill(.black.opacity(0.5)).ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 24) {
                    Text("Calling...")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    Circle().fill(Color(red: 1, green: 87/255, blue: 51/255))
                        .frame(width: 54, height: 54)
                        .overlay(){
                            Image("vnzwa_quit_call").resizable().frame(width: 34, height: 34)
                        }.onTapGesture {
                            dismiss()
                        }
                }.padding(.bottom, 60)
            }
        }.navigationBarHidden(true)
            .onAppear{
                userVM.getUserInfoByUid(uid: vwaljdChatUserId)
            }
    }
}
