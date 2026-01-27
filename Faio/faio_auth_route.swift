import SwiftUI

enum HgywaAppRoute: Hashable {
    case guiding
    case sign
    case main
    case agreementWeb(webUrl: String)
}

enum HgywaUserRoute: Hashable {
    case setting
    case editInfo
    case wallet
    case userList(listType: UwiqonbListType)
    case reportPage
}

enum HgywaWorkRoute: Hashable {
    case postPage
    case workDetail(workId: Int)
}

enum HgywaChatRoute: Hashable {
    case chatRoom(chatRoomId: Int)
    case videoCalling
}

enum HgywaAiRoute: Hashable {
    case aiScriptWritingPresets
    case aiScriptWritingResult(theme: String, style: String, character: String, keywords: String)
    case aiCharacterChatPresets
}

struct FaioAuthRoute: View {

    @State private var appPath = NavigationPath()
    @State private var hasCheckedAuth = false

    private let storage = FaioStorageManager.shared

    var body: some View {
        NavigationStack(path: $appPath) {

            // 👇 占位根视图（不会真正显示）
            Color.clear
                .onAppear {
                    guard !hasCheckedAuth else { return }
                    hasCheckedAuth = true

                    let uid = storage.getCurrentUserId()

                    if uid < 0 {
                        // ✅ 已登录
                        appPath.append(HgywaAppRoute.main)
                    } else {
                        // ❌ 未登录
                        appPath.append(HgywaAppRoute.guiding)
                    }
                }

                // ===== App Route =====
                .navigationDestination(for: HgywaAppRoute.self) { route in
                    switch route {
                    case .guiding:
                        CnalgadGUwjGuidePage(canlAuthPath: $appPath)

                    case .sign:
                        WalfuancvaAvajSign(appPath: $appPath)

                    case .agreementWeb(let webUrl):
                        PonvbnAgreementWeb(ponvbnWebUrl: webUrl)

                    case .main:
                        BienajvfjWangrdNavPage(appPath: $appPath)
                    }
                }

                // ===== User Route =====
                .navigationDestination(for: HgywaUserRoute.self) { route in
                    switch route {
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
                    }
                }

                // ===== Work Route =====
                .navigationDestination(for: HgywaWorkRoute.self) { route in
                    switch route {
                    case .postPage:
                        CnawmnirPostWork()
                    case .workDetail(let workId):
                        RecnxdjWorkDetail(appPath: $appPath, recnxdjWorkId: workId)
                    }
                }

                // ===== Chat Route =====
                .navigationDestination(for: HgywaChatRoute.self) { route in
                    switch route {
                    case .chatRoom(let chatRoomId):
                        OwianChatRoom(appPath: $appPath, owianRoomId: chatRoomId)
                    case .videoCalling:
                        VwaldjgVideoCalling()
                    }
                }

                // ===== AI Route =====
                .navigationDestination(for: HgywaAiRoute.self) { route in
                    switch route {
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
                    }
                }
        }
    }
}

#Preview {
    FaioAuthRoute()
}
