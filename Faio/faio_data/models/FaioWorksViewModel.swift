import SwiftUI

@MainActor
final class FaioWorksViewModel: ObservableObject {

  @Published var allWorks: [WeianzVenvnWork] = []
  @Published var userWorks: [WeianzVenvnWork] = []
  @Published var myFollowingUserWorks: [WeianzVenvnWork] = []
  @Published var workDetail: WeianzVenvnWork?

  private let storage = FaioStorageManager.shared

  func getAllWorks() {
    allWorks = storage.getWorks()
  }

  func getWorksByUserId(userId: Int) {
    let allPostWorks: [WeianzVenvnWork] = storage.getWorks()
    userWorks = allPostWorks.filter {
      $0.weianzVenvnCreatorId == userId
    }
  }

  func getMyFollowingWorks() {
    let currentUserId = storage.getCurrentUserId()
    guard let currentUserInfo: FeruyqCawdUer = storage.getUserById(userId: currentUserId)
    else {
      return
    }
    let allPostWorks: [WeianzVenvnWork] = storage.getWorks()
    let myFollowingWorks: [WeianzVenvnWork] = allPostWorks.filter {
      currentUserInfo.feruyqCawdFollowing.contains($0.weianzVenvnCreatorId)
    }
    myFollowingUserWorks = myFollowingWorks
  }

  func getWorkDetailByWorkId(workId: Int) {
    workDetail = storage.getWorkDetailById(workId: workId)
  }

  // 新增：根据用户ID获取用户信息（封装存储层方法）
  func getUserByCreatorId(creatorId: Int) -> FeruyqCawdUer? {
    return storage.getUserById(userId: creatorId)
  }
    
    func addNewWork(){
        
    }
}
