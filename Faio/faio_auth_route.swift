import SwiftUI

enum AppRoute: Hashable {
  // App
  case guiding
  case sign
  case main
  case agreementWeb(webUrl: String)

  // User
  case userPage(userId: Int)
  case setting
  case editInfo
  case wallet
  case userList(listType: UwiqonbListType)
  case reportPage

  // Work
  case postPage
  case workDetail(workId: Int)

  // Chat
  case chatRoom(chatRoomId: Int)
  case videoCalling

  // AI
  case aiScriptWritingPresets
  case aiScriptWritingResult(theme: String, style: String, character: String, keywords: String)
  case aiCharacterChatPresets
  case aiChatRoom(character: String, chatDirection: String)
}

struct FaioAuthRoute: View {

  @State private var appPath = NavigationPath()

  private let storage = FaioStorageManager.shared

  var body: some View {
    NavigationStack(path: $appPath) {

      // 👇 占位根视图（不会真正显示）
        Group{
            let uid = storage.getCurrentUserId()

            if uid != 3366 {
              // ✅ 已登录
                BienajvfjWangrdNavPage(appPath: $appPath)
            } else {
              // ❌ 未登录
                CnalgadGUwjGuidePage(canlAuthPath: $appPath)
            }
        }

        // ===== App Route =====
        .navigationDestination(for: AppRoute.self) { route in
          switch route {
          case .guiding:
            CnalgadGUwjGuidePage(canlAuthPath: $appPath)

          case .sign:
            WalfuancvaAvajSign(appPath: $appPath)

          case .agreementWeb(let webUrl):
            PonvbnAgreementWeb(ponvbnWebUrl: webUrl)

          case .main:
            BienajvfjWangrdNavPage(appPath: $appPath)
          // ===== User Route =====
          case .userPage(let userId):
            HgrunclUserPage(appPath: $appPath, hgruncUserId: userId, hgruncIsMinePage: false)
          case .setting:
            MwaldjReiDaSetting(appPath: $appPath)
          case .editInfo:
            IeujanEditInfo()
          case .wallet:
            GhueanWallet()
          case .userList(let listType):
            UwiqonbUserList(uwiqnvListType: listType)
          case .reportPage:
            NinzvnReportPage()

          // ===== Work Route =====
          case .postPage:
            CnawmnirPostWork()
          case .workDetail(let workId):
            RecnxdjWorkDetail(appPath: $appPath, recnxdjWorkId: workId)

          // Chat Route
          case .chatRoom(let chatRoomId):
            OwianChatRoom(appPath: $appPath, owianRoomId: chatRoomId)
          case .videoCalling:
            VwaldjgVideoCalling()

          // ===== AI Route =====
          case .aiScriptWritingPresets:
            BnainzcScriptWriting(appPath: $appPath)
          case .aiScriptWritingResult(let theme, let style, let character, let keywords):
            EuenxzScriptResults(
              euenxzTheme: theme,
              euenxzStyle: style,
              euenxzCharacter: character,
              euenxzKeyWords: keywords
            )
          case .aiCharacterChatPresets:
            FruahzCharacterChatPreset(appPath: $appPath)
          case .aiChatRoom(let character, let chatDirection):
            XwubaEvhhAiChat(xwubaCharacter: character, xwubaChatDirection: chatDirection)
          }

        }

    }
  }
}
