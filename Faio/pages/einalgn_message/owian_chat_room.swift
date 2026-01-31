import SwiftUI

struct OwianChatRoom: View {
  @Binding var appPath: NavigationPath

  let owianRoomId: Int

  @State private var owianBottomHeight: CGFloat = 0
  @State private var owianInputText: String = ""
  @FocusState private var owianInputIsFocus: Bool

  @State private var owianIsShowBlock: Bool = false

  @EnvironmentObject var chatVM: FaioChatViewModel
  @EnvironmentObject var userVM: FaioUserViewModel

  @State var owianBlockUserId: Int = 3366

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      if let chatUserInfo: FeruyqCawdUer = chatVM.getChatUserInfo(chatRoomId: owianRoomId) {
        VStack {
          AwicnalWnvTopBar {
            HStack(spacing: 12) {
              ZwnagIreujImage(
                zwnagIreujImageUrl: chatUserInfo.feruyqCawdAvatar, zwnagIreujWidth: 40,
                zwnagIreujHeight: 40, zwnagIreujIsCircle: true)
              Text(chatUserInfo.feruyqCawdUserName)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            }.padding(.leading, 16)
            Spacer()
            HStack(spacing: 16) {
              Button(action: {
                appPath.append(AppRoute.videoCalling(chatUserId: chatUserInfo.feruyqCawdUserId))
              }) {
                Image("vnzwa_icon_call_video").resizable().frame(width: 34, height: 34)
              }
              Button(action: {
                owianBlockUserId = chatUserInfo.feruyqCawdUserId
                owianIsShowBlock = true
              }) {
                Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
              }
            }
          }
          FaioChatMessage(owianRoomId: owianRoomId, owianChatUserInfo: chatUserInfo)

          HStack {
            BawnbvTextField(
              placeholder: "Say somthing.....", text: $owianInputText,
              isFocused: $owianInputIsFocus,
              height: 40, verticalPadding: 9, cornerRadius: 40, keyboardSendAction: .send
            )
            .onSubmit {
              chatVM.addMessage(
                sendMsg: NwuzawiGhrdcjsMessage(
                  nuwzawiGhrdcjsRoomId: owianRoomId,
                  nwuzawiGhrdcjsSendUserId: userVM.currentUser!.feruyqCawdUserId,
                  nwuzawiGhrdcjsTextMsg: owianInputText, nwuzawiGhrdcjsDate: Date()))
              owianInputText = ""
            }

          }.padding(.horizontal, 20).padding(.top, 13)
            .readBottomSafeArea { value in
              owianBottomHeight = value
            }
            .padding(.bottom, owianBottomHeight + 18)
            .background(Rectangle().fill(.black))
            .ignoresSafeArea(edges: .bottom)
        }
      } else {
        Text("No chat user info")
      }

      BottomSheet(isPresented: $owianIsShowBlock) {
        ZcnwinaReportBlockBottom(
          zcnwinaIsShow: $owianIsShowBlock, appPath: $appPath, zcnwinaBlockUserId: owianBlockUserId)
      }
    }.navigationBarHidden(true)
      .onChange(of: owianIsShowBlock) { show in
        guard show == false else { return }

        if let ghaunzMyInfo = userVM.currentUser,
          ghaunzMyInfo.feruyqCawdBlacklist.contains(owianBlockUserId)
        {

          // ⚠️ 确保 NavigationPath 不越界
          if !appPath.isEmpty {
            appPath.removeLast()
          }
        }
      }
      .onTapGesture {
        owianInputIsFocus = false
      }

  }

}

// 聊天消息
struct FaioChatMessage: View {
  let owianRoomId: Int
  let owianChatUserInfo: FeruyqCawdUer
  @EnvironmentObject var chatVM: FaioChatViewModel
  @EnvironmentObject var userVM: FaioUserViewModel
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 20) {
        ForEach(chatVM.chatMessageList) { message in
          FaioMessageRow(
            message: message,
            otherUser: owianChatUserInfo,
            currentUser: userVM.currentUser
          )
        }
      }.padding(20)
    }.onAppear {
      chatVM.getMessageListByChatId(chatRoomId: owianRoomId)
    }
  }

  struct FaioMessageRow: View {

    let message: NwuzawiGhrdcjsMessage
    let otherUser: FeruyqCawdUer
    let currentUser: FeruyqCawdUer?

    var isMe: Bool {
      message.nwuzawiGhrdcjsSendUserId == currentUser?.feruyqCawdUserId
    }

    var body: some View {
      HStack(alignment: .top, spacing: 12) {
        if isMe {
          Spacer()
          messageBubble
          avatar(url: currentUser?.feruyqCawdAvatar)
        } else {
          avatar(url: otherUser.feruyqCawdAvatar)
          messageBubble
          Spacer()
        }
      }
    }

    private var messageBubble: some View {
      Text(message.nwuzawiGhrdcjsTextMsg)
        .font(.system(size: 16))
        .foregroundColor(.black)
        .padding(12)
        .background(bubbleBackground)
    }

    private var bubbleBackground: some View {
      UnevenRoundedRectangle(
        topLeadingRadius: isMe ? 15 : 0,
        bottomLeadingRadius: 15,
        bottomTrailingRadius: 15,
        topTrailingRadius: isMe ? 0 : 15
      )
      .fill(
        isMe
          ? VawinvTheme.FaioColor.gradientOrangeToYellow
          : LinearGradient(
            colors: [.white],
            startPoint: .top,
            endPoint: .bottom
          ))
    }

    private func avatar(url: String?) -> some View {
      ZwnagIreujImage(
        zwnagIreujImageUrl: url ?? "",
        zwnagIreujWidth: 40,
        zwnagIreujHeight: 40,
        zwnagIreujIsCircle: true
      )
    }
  }
}
