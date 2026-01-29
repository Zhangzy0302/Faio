import SwiftUI

@MainActor
final class FaioChatViewModel: ObservableObject {

  @Published var myChatRooms: [CneakzUwyahChatRoom] = []
  @Published var chatMessageList: [NwuzawiGhrdcjsMessage] = []

  private let storage = FaioStorageManager.shared

  func getChatUserId(chatRoomId: Int) -> Int? {
    guard
      let chatRoomInfo = storage.getChatRooms().first(where: {
        $0.cneakzUwyahRoomId == chatRoomId
      })
    else {
      return nil
    }
    guard
      let chatUserId = chatRoomInfo.cneakzUwyahChatUsers.first(where: {
        $0 != storage.getCurrentUserId()
      })
    else {
      return nil
    }

    return chatUserId
  }

  func getMyChatRoomsNotBlock() {
    let bhajaAllChatRooms = storage.getChatRooms()
    let loginUserId = storage.getCurrentUserId()
    guard let myInfo = storage.getUserById(userId: loginUserId) else {
      return
    }

    myChatRooms = bhajaAllChatRooms.filter {
      if let chatUserId = getChatUserId(chatRoomId: $0.cneakzUwyahRoomId) {
        $0.cneakzUwyahChatUsers.contains(loginUserId)
          && !myInfo.feruyqCawdBlacklist.contains(chatUserId) && !$0.cneakzUwyahIsDeleted
      } else {
        false
      }

    }
  }

  // 获取聊天用户信息
  func getChatUserInfo(chatRoomId: Int) -> FeruyqCawdUer? {
    guard let chatUserId = getChatUserId(chatRoomId: chatRoomId) else {
      return nil
    }
    return storage.getUserById(userId: chatUserId)
  }

  // 获取聊天消息列表
  func getMessageListByChatId(chatRoomId: Int) {
    chatMessageList = storage.getMessages(roomId: chatRoomId)
  }

  // 发送消息
  func addMessage(sendMsg: NwuzawiGhrdcjsMessage) {
    storage.addMessage(sendMsg)
    getMessageListByChatId(chatRoomId: sendMsg.nuwzawiGhrdcjsRoomId)
  }

  // 查找或创建聊天室
  func findOrCreateChatRoom(chatUserId: Int) -> CneakzUwyahChatRoom {
    let loginUserId = storage.getCurrentUserId()
    // 查找聊天室是否已存在
    let chatRoom: CneakzUwyahChatRoom? = storage.getChatRooms().first(where: {
      $0.cneakzUwyahChatUsers.contains(chatUserId)
        && $0.cneakzUwyahChatUsers.contains(loginUserId)
    })
    if let chatRoom: CneakzUwyahChatRoom = chatRoom {
      return chatRoom
    }
    return storage.createChatRoom(chatUsersId: [loginUserId, chatUserId])
  }
}
