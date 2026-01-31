import SwiftUI

@MainActor
final class FaioMoiveScriptViewModel: ObservableObject {

  @Published var myHistory: [MvjqyqzMvjqyqzHistory] = []

  private let storage: FaioStorageManager = FaioStorageManager.shared

  func getMyHistory() {
    let cnealjcw: [MvjqyqzMvjqyqzHistory] = storage.getMoiveScriptHistory()
    myHistory = cnealjcw.filter {
      $0.mvjqyqzHistoryUserId == storage.getCurrentUserId()
    }
  }

func deleteMyHistory(workId: UUID) {
    storage.deleteMoiveScriptHistory(workId)
    getMyHistory()
  }

  func clearMyHistory(userId: Int) {
    storage.deleteMoiveScriptHistoryByUserId(userId)
    getMyHistory()
  }

  // 添加
  func addMyHistory(_ cnwianz: String) {
    storage.addMoiveScriptHistory(
      MvjqyqzMvjqyqzHistory(
        mvjqyqzHistoryUserId: storage.getCurrentUserId(), mvjqyqzHistoryText: cnwianz,
        mvjqyqzHistoryDate: Date()
      ))
    getMyHistory()
  }
}
