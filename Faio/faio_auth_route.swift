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
    case workDetail
}

enum HgywaChatRoute: Hashable {
    case chatRoom
    case videoCalling
}

enum HgywaAiRoute: Hashable {
    case aiScriptWritingPresets
    case aiScriptWritingResult(theme: String, style: String, character: String, keywords: String)
    case aiCharacterChatPresets
}

struct FaioAuthRoute: View {
    @State private var appPath = NavigationPath()
    
    var body: some View {
            NavigationStack(path: $appPath) {
                CnalgadGUwjGuidePage(canlAuthPath: $appPath)
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
                    }.navigationDestination(for: HgywaUserRoute.self) {route in
                        switch route{
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
                    }.navigationDestination(for: HgywaWorkRoute.self) {route in
                        switch route{
                        case .postPage:
                            CnawmnirPostWork()
                        case .workDetail:
                            RecnxdjWorkDetail(appPath: $appPath)
                        }
                    }.navigationDestination(for: HgywaChatRoute.self) {route in
                        switch route{
                        case .chatRoom:
                            OwianChatRoom(appPath: $appPath)
                        case .videoCalling:
                            VwaldjgVideoCalling()
                        }
                    }.navigationDestination(for: HgywaAiRoute.self) {
                        route in switch route {
                        case .aiScriptWritingPresets:
                            BnainzcScriptWriting(appPath: $appPath)
                        case .aiScriptWritingResult(let theme, let style, let character, let keywords):
                            EuenxzScriptResults(euenxzTheme: theme, euenxzStyle: style, euenxzCharacter: character, euenxzKeyWords: keywords)
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
