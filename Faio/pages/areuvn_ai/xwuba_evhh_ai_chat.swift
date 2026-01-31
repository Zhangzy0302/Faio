import SwiftUI

struct XwubaEvhhAiChat: View {
  let xwubaCharacter: String
  let xwubaChatDirection: String
  let xwubaCharacterName: String

  @State private var xwubaEvhhInput: String = ""
  @FocusState private var xwubaEvhhIsFocused: Bool

  @State private var owianBottomHeight: CGFloat = 0

  @State private var xuwbaChatMessageList: [XwuajbChatMsg] = []
  @State private var xuwbaChatIsLoading: Bool = false

  func xuwbaRequestAiApi(xwubaSendText: String) async {
    do {
      xuwbaChatMessageList.append(
        XwuajbChatMsg(id: UUID(), xwuajbSendByMyself: true, xuwajbSendText: xwubaSendText)
      )
      xwubaEvhhInput = ""
      xuwbaChatIsLoading = true
      let data = try await vnefajAiCall(xwubaSendText)
      let decoded = try JSONDecoder().decode(AiResponse.self, from: data)

      if let aiText = decoded.result.output.choices.first?.message.content {
        xuwbaChatIsLoading = false
        xuwbaChatMessageList.append(
          XwuajbChatMsg(id: UUID(), xwuajbSendByMyself: false, xuwajbSendText: aiText)
        )
      }
    } catch {
      xuwbaChatIsLoading = false
      print("Parsing failed:", error)
    }
  }

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar()
        ScrollView {
          LazyVStack(spacing: 20) {
            ForEach(xuwbaChatMessageList, id: \.id) { list in
              xwubaChatMsgItem(xuwadMsg: list)
            }
          }
        }
        HStack {
          Group {
            if xuwbaChatIsLoading {
              HStack(spacing: 12) {
                Spacer()
                ProgressView()
                  .progressViewStyle(.circular)
                  .scaleEffect(1.1)
                  .tint(.white)

                Text("AI is thinking")
                  .font(.system(size: 16))
                  .fontWeight(.regular)
                  .foregroundColor(.white)
                Spacer()
              }.frame(height: 40)
            } else {
              BawnbvTextField(
                placeholder: "Say somthing.....", text: $xwubaEvhhInput,
                isFocused: $xwubaEvhhIsFocused,
                height: 40, verticalPadding: 9, cornerRadius: 40, keyboardSendAction: .send
              )
              .onSubmit {
                if xwubaEvhhInput.isEmpty {
                  return
                }
                Task {
                  await xuwbaRequestAiApi(xwubaSendText: xwubaEvhhInput)
                }
              }
            }
          }

        }.padding(.horizontal, 20).padding(.top, 13)
          .readBottomSafeArea { value in
            owianBottomHeight = value
          }
          .padding(.bottom, owianBottomHeight + 18)
          .background(Rectangle().fill(.black).ignoresSafeArea(edges: .bottom))

      }
    }.onTapGesture {
      xwubaEvhhIsFocused = false
    }.navigationBarHidden(true)
      .onAppear {
        xuwbaChatMessageList.append(
          XwuajbChatMsg(
            id: UUID(), xwuajbSendByMyself: false,
            xuwajbSendText: "Hey, dear friend! I am \(xwubaCharacterName)"))
      }
  }

  private struct xwubaChatMsgItem: View {
    let xuwadMsg: XwuajbChatMsg

    var body: some View {
      VStack {
        Group {
          if !xuwadMsg.xwuajbSendByMyself {
            HStack(alignment: .top, spacing: 12) {
              Circle().fill(
                LinearGradient(
                  colors: [
                    Color(red: 41 / 255, green: 116 / 255, blue: 80 / 255),
                    Color(red: 47 / 255, green: 206 / 255, blue: 196 / 255),
                  ], startPoint: .bottom, endPoint: .top)
              ).frame(width: 40)
                .overlay {
                  Image("vnzwa_character_chat").resizable().frame(width: 34, height: 34)
                }
              Text(xuwadMsg.xuwajbSendText)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(12)
                .background(
                  UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 15,
                    bottomTrailingRadius: 15,
                    topTrailingRadius: 15
                  )
                  .fill(Color.white)
                )
              Spacer()
            }
          } else {
            HStack(alignment: .top, spacing: 12) {
              Spacer()
              Text(xuwadMsg.xuwajbSendText)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding(12)
                .background(
                  UnevenRoundedRectangle(
                    topLeadingRadius: 15,
                    bottomLeadingRadius: 15,
                    bottomTrailingRadius: 15,
                    topTrailingRadius: 0
                  )
                  .fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                )
              zxainfUserAvatar()
            }
          }
        }

      }.padding(.horizontal, 20)
    }
  }

  private struct zxainfUserAvatar: View {
    @EnvironmentObject var userVM: FaioUserViewModel

    var body: some View {
      if let cianaMyInfo: FeruyqCawdUer = userVM.currentUser {
        ZwnagIreujImage(
          zwnagIreujImageUrl: cianaMyInfo.feruyqCawdAvatar, zwnagIreujWidth: 40,
          zwnagIreujHeight: 40, zwnagIreujIsCircle: true)
      }
    }
  }
}

struct XwuajbChatMsg {
  let id: UUID
  let xwuajbSendByMyself: Bool
  let xuwajbSendText: String
}
