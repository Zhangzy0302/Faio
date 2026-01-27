
import SwiftUI

@MainActor
final class FaioCommentsViewModel: ObservableObject {

    @Published var workComments: [CBawialBMeiComment] = []

    private let storage = FaioStorageManager.shared
    
    func getCommentsByWorkId(workId: Int) {
        workComments = storage.getComments(for: workId)
    }
    
    func getCommetUserInfo(userId: Int) -> FeruyqCawdUer? {
        return storage.getUserById(userId: userId)
    }
}
