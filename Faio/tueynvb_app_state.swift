import SwiftUI

final class TueynvbAppState {

  private init() {}

  private static let defaults = UserDefaults.standard

  static var isAgree: Bool {
    get { defaults.bool(forKey: "isAgree") }
    set { defaults.set(newValue, forKey: "isAgree") }
  }

  // 判断A/B 包
  static var isSuccess: Bool {
    get { defaults.bool(forKey: "isSuccess") }
    set { defaults.set(newValue, forKey: "isSuccess") }
  }

}

var waknxaPaksUsersOrdercode: String = ""
