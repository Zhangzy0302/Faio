import SwiftUI

final class TueynvbAppState {

  private init() {}

  private static let defaults = UserDefaults.standard

  static var isAgree: Bool {
    get { defaults.bool(forKey: "isAgree") }
    set { defaults.set(newValue, forKey: "isAgree") }
  }
}
