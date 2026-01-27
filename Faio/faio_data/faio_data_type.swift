

import SwiftUI

struct FeruyqCawdUer: Codable, Identifiable, Equatable {
    
    let feruyqCawdUserId: Int
    var feruyqCawdEmail: String
    var feruyqCawdPassword: String
    var feruyqCawdUserName: String
    var feruyqCawdAvatar: String
    var feruyqCawdAboutMe: String
    var feruyqCawdFollowing: [Int]
    var feruyqCawdFans: [Int]
    var feruyqCawdBlacklist: [Int]
    var feruyqCawdWalletBalance: Int
    
    var feruyqCawdLikeWorks: [Int]
    
    // MARK: - Identifiable
    var id: Int {feruyqCawdUserId}
}

struct WeianzVenvnWork: Codable, Identifiable, Equatable {
    
    let weianzVenvnWorkId: Int
    var weianzVenvnCreatorId: Int
    var weianzVenvnTextContent: String
    var weianzVenvnImageListUrl: [String]
    var weianzVenvnDate: Date
    
    var id: Int { weianzVenvnWorkId }
}

struct CBawialBMeiComment: Codable, Identifiable, Equatable {
    
    let cBawialBMeiCommentId: Int
    var cBawialBMeiCommentUserId: Int
    var cBawialBMeiCommentText: String
    var cBawialBMeiDate: Date
    
    var id: Int { cBawialBMeiCommentId }
}

struct CneakzUwyahChatRoom: Codable, Identifiable, Equatable {
    
    let cneakzUwyahRoomId: Int
    var cneakzUwyahChatUsers: [Int]
    var cneakzUwyahLastSendMsg: String
    var cneakzUwyahLastSendTime: Date
    var cneakzUwyahUnreadCount: Int
    
    var id: Int{ cneakzUwyahRoomId }
}

struct NwuzawiGhrdcjsMessage: Codable, Identifiable, Equatable {
    
    let nwuzawiGhrdcjsMsgId: Int
    var nwuzawiGhrdcjsSendUserId: Int
    var nwuzawiGhrdcjsTextMsg: String
    var nwuzawiGhrdcjsDate: Date
    
    var id: Int { nwuzawiGhrdcjsMsgId }
}
