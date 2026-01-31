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

  func returnUserInfoById(userId: Int) -> FeruyqCawdUer? {
    storage.getUserById(userId: userId)
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

  // 注册
  func register(email: String, password: String) -> FeruyqCawdUer? {
    let users = storage.getUsers()
    guard
      users.first(where: { $0.feruyqCawdEmail == email }) == nil
    else {
      return nil
    }

    let newUser: FeruyqCawdUer = FeruyqCawdUer(
      feruyqCawdUserId: users.count,
      feruyqCawdEmail: email,
      feruyqCawdPassword: password,
      feruyqCawdUserName: "User_" + String(users.count),
      feruyqCawdAvatar: "vnzwa_default_avatar",
      feruyqCawdAboutMe: "new User",
      feruyqCawdFollowing: [],
      feruyqCawdFans: [],
      feruyqCawdBlacklist: [],
      feruyqCawdWalletBalance: 0,
      feruyqCawdLikeWorks: [],
      feruyqCawdIsDeleted: false
    )

    storage.addUser(user: newUser)
    storage.setCurrentUserId(newUser.feruyqCawdUserId)
    loadLoginUser()
    return newUser
  }

  // 登出
  func logout() {
    storage.setCurrentUserId(3366)
    loadLoginUser()
  }

  // 切换用户状态
  func toggleUserIsDeleted() {
    storage.updateUser(uid: currentUser!.feruyqCawdUserId) { user in
      var newUser: FeruyqCawdUer = user
      newUser.feruyqCawdIsDeleted = !newUser.feruyqCawdIsDeleted
      return newUser
    }

    loadLoginUser()
  }

  // 切换拉黑状态
  func toggleUserIsBlocked(blockUserId: Int) {
    storage.updateUser(uid: currentUser!.feruyqCawdUserId) { user in
      var newUser: FeruyqCawdUer = user
      if newUser.feruyqCawdBlacklist.contains(blockUserId) {
        newUser.feruyqCawdBlacklist.removeAll { $0 == blockUserId }
      } else {
        newUser.feruyqCawdBlacklist.append(blockUserId)
      }

      return newUser
    }

    loadLoginUser()
  }

  // 切换是否喜欢作品
  func toggleWorkIsLiked(workId: Int) {
    storage.updateUser(uid: currentUser!.feruyqCawdUserId) { user in
      var newUser: FeruyqCawdUer = user
      if newUser.feruyqCawdLikeWorks.contains(workId) {
        newUser.feruyqCawdLikeWorks.removeAll { $0 == workId }
      } else {
        newUser.feruyqCawdLikeWorks.append(workId)
      }
      return newUser
    }
    loadLoginUser()
  }

  // 切换关注状态
  func toggleUserIsFollowed(followUserId: Int) {
    guard let currentUser = currentUser else { return }

    // 1️⃣ 更新当前用户
    storage.updateUser(uid: currentUser.feruyqCawdUserId) { user in
      var newUser = user

      if newUser.feruyqCawdFollowing.contains(followUserId) {
        newUser.feruyqCawdFollowing.removeAll { $0 == followUserId }
      } else {
        newUser.feruyqCawdFollowing.append(followUserId)
      }

      return newUser
    }

    // 2️⃣ 更新被关注用户
    storage.updateUser(uid: followUserId) { user in
      var newFollowUser = user

      if newFollowUser.feruyqCawdFans.contains(currentUser.feruyqCawdUserId) {
        newFollowUser.feruyqCawdFans.removeAll { $0 == currentUser.feruyqCawdUserId }
      } else {
        newFollowUser.feruyqCawdFans.append(currentUser.feruyqCawdUserId)
      }

      return newFollowUser
    }

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
