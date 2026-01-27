import SwiftUI

@MainActor
final class FaioChatViewModel: ObservableObject {

    @Published var myChatRooms: [CneakzUwyahChatRoom] = []
    @Published var chatMessageList: [NwuzawiGhrdcjsMessage] = []

    private let storage = FaioStorageManager.shared
    
    func getMyChatRooms() {
        let bhajaAllChatRooms = storage.getChatRooms()
        let loginUserId = storage.getCurrentUserId()
        myChatRooms = bhajaAllChatRooms.filter{
            $0.cneakzUwyahChatUsers.contains(loginUserId)
        }
    }
    
    func getMessageListByChatId(chatRoomId: Int) {
        chatMessageList = storage.getMessages(roomId: chatRoomId)
    }
}
