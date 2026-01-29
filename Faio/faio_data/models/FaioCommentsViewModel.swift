import SwiftUI

@MainActor
final class FaioCommentsViewModel: ObservableObject {

  @Published var workCommentsNotBlock: [CBawialBMeiComment] = []

  private let storage = FaioStorageManager.shared

  func getCommentsNotBlockByWorkId(workId: Int) {
    let allComments: [CBawialBMeiComment] = storage.getComments(for: workId)
    guard let loginUserInfo: FeruyqCawdUer = storage.getUserById(userId: storage.getCurrentUserId()) else {
      return
    }
    workCommentsNotBlock = allComments.filter {
      !loginUserInfo.feruyqCawdBlacklist.contains($0.cBawialBMeiCommentUserId)
    }
  }

  func getCommetUserInfo(userId: Int) -> FeruyqCawdUer? {
    return storage.getUserById(userId: userId)
  }
    
    func addCommentItem(commentItem: CBawialBMeiComment) {
        storage.addComment(commentItem)
        
    }
}
