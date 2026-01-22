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
}

enum HgywaWorkRoute: Hashable {
    case postPage
    case workDetail
}

enum HgywaChatRoute: Hashable {
    case chatRoom
    case videoCalling
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
                            OwianChatRoom()
                        case .videoCalling:
                            VwaldjgVideoCalling()
                        }
                    }
            }
        }
}

#Preview {
    FaioAuthRoute()
}
