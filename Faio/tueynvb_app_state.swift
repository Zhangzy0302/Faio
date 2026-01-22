import SwiftUI

final class TueynvbAppState {

    private init() {}

    private static let defaults = UserDefaults.standard

    // 是否已登录
    static var isLogin: Bool {
        get { defaults.bool(forKey: "isLogin") }
        set { defaults.set(newValue, forKey: "isLogin") }
    }

    // 用户 id
    static var userId: String? {
        get { defaults.string(forKey: "userId") }
        set { defaults.set(newValue, forKey: "userId") }
    }

    static var isAgree: Bool {
        get { defaults.bool(forKey: "isAgree") }
        set { defaults.set(newValue, forKey: "isAgree") }
    }
}
