//
//  FaioApp.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI
@_exported import HotSwiftUI

@main
struct FaioApp: App {
    init() {
    #if DEBUG
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
      if let path = Bundle.main.path(
        forResource:
          "iOSInjection", ofType: "bundle")
      {
        Bundle(path: path)!.load()
      }
    #endif
        UITextField.appearance().tintColor = .black
    }
    var body: some Scene {
        WindowGroup {
            FaioAuthRoute()
        }
    }
}
