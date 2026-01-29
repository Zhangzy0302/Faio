import SwiftUI

@MainActor
final class FaioUserViewModel: ObservableObject {

  @Published var users: [FeruyqCawdUer] = []
  @Published var currentUser: FeruyqCawdUer?
  @Published var userInfo: FeruyqCawdUer?

  private let storage = FaioStorageManager.shared

  func getUserInfoByUid(uid: Int) {
    userInfo = storage.getUserById(userId: uid)
  }

  func loadLoginUser() {
    users = storage.getUsers()

    let uid: Int = storage.getCurrentUserId()
    currentUser = users.first { $0.feruyqCawdUserId == uid }
  }

  // 登录
  func loginByEmailAndPassword(email: String, password: String) -> FeruyqCawdUer? {
    let users = storage.getUsers()
    guard
      let matchUser = users.first(where: {
        $0.feruyqCawdEmail == email && $0.feruyqCawdPassword == password && !$0.feruyqCawdIsDeleted
      })
    else {
      return nil
    }

    // 记录登录态
    storage.setCurrentUserId(matchUser.feruyqCawdUserId)
    loadLoginUser()
    return matchUser
  }

  // 游客登录
  func visitorLogin() {
    storage.setCurrentUserId(5)
    loadLoginUser()
  }

  // 登出
  func logout() {
    storage.setCurrentUserId(3366)
    loadLoginUser()
  }

  // 修改用户信息
  func editUserInfo(name: String, aboutMe: String, avatar: String) {
    storage.updateUser(uid: currentUser!.feruyqCawdUserId) { user in
      var newUser: FeruyqCawdUer = user
      newUser.feruyqCawdUserName = name
      newUser.feruyqCawdAvatar = avatar
      newUser.feruyqCawdAboutMe = aboutMe
      return newUser
    }

    loadLoginUser()
  }

  // 更新用户钻石数
  func increaseUserDiamond(diamond: Int) {
    storage.updateUser(uid: currentUser!.feruyqCawdUserId) { user in
      var newUser: FeruyqCawdUer = user
      newUser.feruyqCawdWalletBalance = newUser.feruyqCawdWalletBalance + diamond
      return newUser
    }
    
    loadLoginUser()
  }
}
