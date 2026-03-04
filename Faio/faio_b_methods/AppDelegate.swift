//
//  AppDelegate.swift
//  Faio
//
//  Created by yangyang on 2026/2/26.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        registerPush(application)

        return true
    }

    private func registerPush(_ application: UIApplication) {

        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in

            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {

        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

        print("Push Token:", token)

        // 保存
        TeabzbaAppStorage.teabzbaPushToken = token
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Push 注册失败:", error)
    }
}
