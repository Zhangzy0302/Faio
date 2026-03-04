//
//  teabzba_b_info.swift
//  Faio
//
//  Created by yangyang on 2026/2/25.
//

import Foundation
import Security

final class GhwbAMaldwiBInfo {

  // MARK: - Keychain Service
  private static let service = "com.wakjal.aiowix.circle"

  // MARK: - 初始化
  static func initGhwbAMaldwiStorage() {
    getAllStorageData()
  }

  static func getAllStorageData() {

    devidGhwbAMaldwi =
      read(key: "devidGhwbAMaldwi_3")

    passwordGhwbAMaldwi =
      read(key: "passwordGhwbAMaldwi_3")

  }
}

extension GhwbAMaldwiBInfo {

  static var devidGhwbAMaldwi: String?

  static var getDevid: String {
    devidGhwbAMaldwi ?? ""
  }

  static func saveDevid(_ value: String) {
    devidGhwbAMaldwi = value
    save(key: "devidGhwbAMaldwi_3", value: value)
  }
}

extension GhwbAMaldwiBInfo {

  static var passwordGhwbAMaldwi: String?

  static var getPassword: String {
    passwordGhwbAMaldwi ?? ""
  }

  static func savePassword(_ value: String) {
    passwordGhwbAMaldwi = value
    save(key: "passwordGhwbAMaldwi_3", value: value)
  }
}

extension GhwbAMaldwiBInfo {

  fileprivate static func save(key: String, value: String) {
    let data = value.data(using: .utf8)!

    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: key,
    ]

    SecItemDelete(query as CFDictionary)

    var attributes = query
    attributes[kSecValueData as String] = data

    // 等价 Flutter KeychainAccessibility.first_unlock
    attributes[kSecAttrAccessible as String] =
      kSecAttrAccessibleAfterFirstUnlock

    SecItemAdd(attributes as CFDictionary, nil)
  }

  fileprivate static func read(key: String) -> String? {

    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: key,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne,
    ]

    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)

    guard status == errSecSuccess,
      let data = result as? Data,
      let string = String(data: data, encoding: .utf8)
    else {
      return nil
    }

    return string
  }
}

// 卸载后不持久
enum TeabzbaAppStorageKey {
  static let teabzbaIsB = "teabzbaIsB"
  static let teabzbaPushToken = "teabzbaPushToken"
  static let teabzbaUserToken = "teabzbaUserToken"
  static let teabzbaH5Url = "teabzbaH5Url"
}

final class TeabzbaAppStorage {

  private static let ud = UserDefaults.standard

  // MARK: - isAorB
  static var teabzbaIsB: Bool {
    get { ud.bool(forKey: TeabzbaAppStorageKey.teabzbaIsB) }
    set { ud.set(newValue, forKey: TeabzbaAppStorageKey.teabzbaIsB) }
  }

  // MARK: - pushToken
  static var teabzbaPushToken: String {
    get { ud.string(forKey: TeabzbaAppStorageKey.teabzbaPushToken) ?? "" }
    set { ud.set(newValue, forKey: TeabzbaAppStorageKey.teabzbaPushToken) }
  }

  // MARK: - userToken
  static var teabzbaUserToken: String {
    get { ud.string(forKey: TeabzbaAppStorageKey.teabzbaUserToken) ?? "" }
    set { ud.set(newValue, forKey: TeabzbaAppStorageKey.teabzbaUserToken) }
  }

  // MARK: - h5Url
  static var teabzbaH5Url: String {
    get { ud.string(forKey: TeabzbaAppStorageKey.teabzbaH5Url) ?? "" }
    set { ud.set(newValue, forKey: TeabzbaAppStorageKey.teabzbaH5Url) }
  }
}
