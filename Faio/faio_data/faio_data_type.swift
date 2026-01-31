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
  var feruyqCawdIsDeleted: Bool

  // MARK: - Identifiable
  var id: Int { feruyqCawdUserId }
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

  let id: UUID = UUID()

  var cBawialBMeiCommentWorkId: Int
  var cBawialBMeiCommentUserId: Int
  var cBawialBMeiCommentText: String
  var cBawialBMeiDate: Date

  enum CodingKeys: String, CodingKey {
    case cBawialBMeiCommentWorkId
    case cBawialBMeiCommentUserId
    case cBawialBMeiCommentText
    case cBawialBMeiDate
  }
}

struct CneakzUwyahChatRoom: Codable, Identifiable, Equatable {

  let cneakzUwyahRoomId: Int
  var cneakzUwyahChatUsers: [Int]
  var cneakzUwyahLastSendMsg: String
  var cneakzUwyahLastSendTime: Date
  var cneakzUwyahUnreadCount: Int
  var cneakzUwyahIsDeleted: Bool

  var id: Int { cneakzUwyahRoomId }
}

struct NwuzawiGhrdcjsMessage: Codable, Identifiable, Equatable {

  let id: UUID = UUID()

  var nuwzawiGhrdcjsRoomId: Int
  var nwuzawiGhrdcjsSendUserId: Int
  var nwuzawiGhrdcjsTextMsg: String
  var nwuzawiGhrdcjsDate: Date

  enum CodingKeys: String, CodingKey {
    case nuwzawiGhrdcjsRoomId
    case nwuzawiGhrdcjsSendUserId
    case nwuzawiGhrdcjsTextMsg
    case nwuzawiGhrdcjsDate
  }
}

// 电影脚本生成历史记录
struct MvjqyqzMvjqyqzHistory: Codable, Identifiable, Equatable {
  let id: UUID = UUID()
  var mvjqyqzHistoryUserId: Int
  var mvjqyqzHistoryText: String
  var mvjqyqzHistoryDate: Date

  enum CodingKeys: String, CodingKey {
    case mvjqyqzHistoryUserId
    case mvjqyqzHistoryText
    case mvjqyqzHistoryDate
  }
}
