import SwiftUI

struct EiwnbMessagePage: View {

  @Binding var appPath: NavigationPath

  @EnvironmentObject var eiwnbChatVM: FaioChatViewModel

  var body: some View {
    VStack(alignment: .leading) {

      ZStack(alignment: .bottomLeading) {
        Rectangle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow).frame(width: 80, height: 12)
          .cornerRadius(15)
        Text("Message").font(.system(size: 28))
          .fontWeight(.heavy)
          .foregroundColor(.white)
          .shadow(color: .black, radius: 0, x: 1, y: 2)
      }.padding(.leading, 20).padding(.top, 16).padding(.bottom, 30)

      ScrollView {
        LazyVStack(spacing: 30) {
          Group {
            if eiwnbChatVM.myChatRooms.count > 0 {
              ForEach(eiwnbChatVM.myChatRooms) { chatRoom in
                Button(action: {
                  appPath.append(AppRoute.chatRoom(chatRoomId: chatRoom.cneakzUwyahRoomId))
                }) {
                  HStack {
                    if let eiwncUserInfo = eiwnbChatVM.getChatUserInfo(
                      chatRoomId: chatRoom.cneakzUwyahRoomId)
                    {
                      ZwnagIreujImage(
                        zwnagIreujImageUrl: eiwncUserInfo.feruyqCawdAvatar, zwnagIreujWidth: 60,
                        zwnagIreujHeight: 60, zwnagIreujIsCircle: true
                      ).padding(.trailing, 12)
                      VStack(alignment: .leading, spacing: 4) {
                        Text(eiwncUserInfo.feruyqCawdUserName)
                          .font(.system(size: 16))
                          .fontWeight(.semibold).foregroundColor(.white)
                        Text(chatRoom.cneakzUwyahLastSendMsg)
                          .font(.system(size: 12))
                          .fontWeight(.regular).foregroundColor(.white.opacity(0.5))
                      }
                    }
                    Spacer()
                    VStack {
                      Text(chatRoom.cneakzUwyahLastSendTime.toString())
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.4))
                    }
                  }.padding(.horizontal, 20)
                }

              }
            } else {
              XgkgaldEmptyDataPlaceholder(topPadding: 120)
            }
          }
        }
      }
    }.onAppear {
      eiwnbChatVM.getMyChatRoomsNotBlock()
    }
  }
}
