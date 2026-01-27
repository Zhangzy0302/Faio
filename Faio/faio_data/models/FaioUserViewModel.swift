import SwiftUI

@MainActor
final class FaioUserViewModel: ObservableObject {

    @Published var users: [FeruyqCawdUer] = []
    @Published var currentUser: FeruyqCawdUer?
    @Published var userInfo: FeruyqCawdUer?

    private let storage = FaioStorageManager.shared
    
    func loadUserInfoByUid(uid: Int) {
        users = storage.getUsers()
        userInfo = users.first { $0.feruyqCawdUserId == uid }
    }

    func loadLoginUser() {
        users = storage.getUsers()

        let uid = storage.getCurrentUserId()
        currentUser = users.first { $0.feruyqCawdUserId == uid }
    }
    
    func loginByEmailAndPassword(email: String, password: String) -> FeruyqCawdUer? {
        currentUser = storage.login(email: email, password: password)
        return currentUser
    }

    func updateName(_ name: String) {
        guard let uid = currentUser?.feruyqCawdUserId else { return }

        storage.updateUser(uid: uid) { user in
            var newUser = user
            newUser.feruyqCawdUserName = name
            return newUser
        }

        loadLoginUser()
    }
    
}
