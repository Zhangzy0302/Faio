//
//  FaioApp.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

@main
struct FaioApp: App {
    
    @StateObject private var userVM = FaioUserViewModel()
    @StateObject private var workVM = FaioWorksViewModel()
    @StateObject private var chatVM = FaioChatViewModel()
    @StateObject private var commentVM = FaioCommentsViewModel()
    
    init() {
        UITextField.appearance().tintColor = .black
        
    }
    var body: some Scene {
        WindowGroup {
            FaioAuthRoute()
                .environmentObject(userVM)
                .environmentObject(workVM)
                .environmentObject(chatVM)
                .environmentObject(commentVM)
                .onAppear{
                    FaioStorageManager.shared.initializeAllDefaults()
                    
                    workVM.getAllWorks()
                    chatVM.getMyChatRoomsNotBlock()
                }.overlay {
                    FaioHUDView()
                    }
        }
    }
}
