
import SwiftUI

@MainActor
final class FaioWorksViewModel: ObservableObject {

    @Published var allWorks: [WeianzVenvnWork] = []
    @Published var userWorks: [WeianzVenvnWork] = []
    @Published var workDetail: WeianzVenvnWork?

    private let storage = FaioStorageManager.shared
    
    func getAllWorks() {
        allWorks = storage.getWorks()
    }
    
    func getWorksByUserId(userId: Int) {
        let allPostWorks = storage.getWorks()
        userWorks = allPostWorks.filter{
            $0.weianzVenvnCreatorId == userId
        }
    }
    
    func getWorkDetailByWorkId(workId: Int) {
        workDetail = storage.getWorkDetailById(workId: workId)
    }
    
    // 新增：根据用户ID获取用户信息（封装存储层方法）
    func getUserByCreatorId(creatorId: Int) -> FeruyqCawdUer? {
        return storage.getUserById(userId: creatorId)
    }
}
