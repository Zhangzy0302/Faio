//
//  FaioApp.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import AdSupport
import AdjustSdk
import AppTrackingTransparency
import SwiftUI

@main
struct FaioApp: App {

  @StateObject private var userVM = FaioUserViewModel()
  @StateObject private var workVM = FaioWorksViewModel()
  @StateObject private var chatVM = FaioChatViewModel()
  @StateObject private var commentVM = FaioCommentsViewModel()
  @StateObject private var moiveScriptVM = FaioMoiveScriptViewModel()
  @UIApplicationDelegateAdaptor(AppDelegate.self)
  var appDelegate
  @StateObject var iapManager: IAPManager

  init() {
    UserDefaults.standard.register(defaults: [
      TeabzbaAppStorageKey.teabzbaIsB: false,
      TeabzbaAppStorageKey.teabzbaPushToken: "",
      TeabzbaAppStorageKey.teabzbaH5Url: "",
    ])
    AdjustManager.shared.initialize()
//    AdjustManager.shared.requestTrackingPermission()

    UITextField.appearance().tintColor = .black
    let userVM = FaioUserViewModel()
    _userVM = StateObject(wrappedValue: userVM)
    _iapManager = StateObject(wrappedValue: IAPManager(userVM: userVM))
  }

  var body: some Scene {
    WindowGroup {
      ZStack {
        FaioAuthRoute()
          .environmentObject(userVM)
          .environmentObject(workVM)
          .environmentObject(chatVM)
          .environmentObject(commentVM)
          .environmentObject(moiveScriptVM)
          .environmentObject(iapManager)
          .onAppear {
            FaioStorageManager.shared.initializeAllDefaults()
            GhwbAMaldwiBInfo.initGhwbAMaldwiStorage()

            workVM.getAllWorks()
            chatVM.getMyChatRoomsNotBlock()
          }
        FaioHUDView()
      }

    }
  }
}

final class AdjustManager: UIResponder, UIApplicationDelegate, AdjustDelegate {

  static let shared = AdjustManager()

  private let installToken = "mid9we"
  private let purchaseToken = "2pfvjh"
  private let appToken = "9rtv2h1w591c"

  private override init() {}

  // MARK: - 初始化
  func initialize() {
    guard
      let config = ADJConfig(
        appToken: appToken,
        environment: ADJEnvironmentProduction
      )
    else { return }

    config.logLevel = ADJLogLevel.verbose
    config.enableSendingInBackground()
    config.delegate = self
    Adjust.addGlobalCallbackParameter(purchaseToken, forKey: "ta_distinct_id")
    Adjust.attribution { attribution in
      // add your completion handler
      self.adjustAttributionChanged(attribution)
      print("init attribution: \(attribution)")
    }
    Adjust.initSdk(config)
  }

  // MARK: - 安装事件
  func adjustAttributionChanged(_ attribution: ADJAttribution?) {
    let event = ADJEvent(eventToken: installToken)
    Adjust.trackEvent(event)
  }

  // MARK: - 购买事件
  func trackPurchase(dollar: Double) {
    let event = ADJEvent(eventToken: purchaseToken)
    event?.setRevenue(dollar, currency: "USD")
    Adjust.trackEvent(event)
  }

  // MARK: - 请求 ATT 权限
//  func requestTrackingPermission() {
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//      if #available(iOS 14, *) {
//        ATTrackingManager.requestTrackingAuthorization { status in
//          print("ATT status:", status.rawValue)
//        }
//      }
//    }
//  }
}
