import SwiftUI
import Foundation

final class FaioStorageManager {

    static let shared = FaioStorageManager()
    private init() {}

    private let storage = UserDefaults.standard

    // MARK: - Keys
    private enum Keys {
        static let users = "feruyqCawdUsers"
        static let works = "weianzVenvnWorks"
        static let comments = "cBawialBMeiComments"
        static let chatRooms = "cneakzUwyahChatRooms"
        static let messages = "nwuzawiGhrdcjsMessages"
        static let currentUserId = "faioCurrentUserId"
    }
}

extension FaioStorageManager {

    func initializeAllDefaults() {
        initializeUsersIfNeeded()
        initializeWorksIfNeeded()
        initializeCommentsIfNeeded()
        initializeChatRoomsIfNeeded()
        initializeMessagesIfNeeded()
    }
    
    private func initializeUsersIfNeeded() {
            guard storage.data(forKey: Keys.users) == nil else { return }

            let users: [FeruyqCawdUer] = [
                FeruyqCawdUer(
                    feruyqCawdUserId: 0,
                    feruyqCawdEmail: "faio@gmail.com",
                    feruyqCawdPassword: "123456",
                    feruyqCawdUserName: "Manner",
                    feruyqCawdAvatar: "bnunea_ava_0",
                    feruyqCawdAboutMe: "Hello Faio",
                    feruyqCawdFollowing: [1],
                    feruyqCawdFans: [],
                    feruyqCawdBlacklist: [],
                    feruyqCawdWalletBalance: 1000,
                    feruyqCawdLikeWorks: []
                ),
                FeruyqCawdUer(
                    feruyqCawdUserId: 1,
                    feruyqCawdEmail: "wadadvnq@gmail.com",
                    feruyqCawdPassword: "uw54a",
                    feruyqCawdUserName: "ikaimelavie",
                    feruyqCawdAvatar: "bnunea_ava_1",
                    feruyqCawdAboutMe: "",
                    feruyqCawdFollowing: [],
                    feruyqCawdFans: [0],
                    feruyqCawdBlacklist: [],
                    feruyqCawdWalletBalance: 0,
                    feruyqCawdLikeWorks: []
                ),
                FeruyqCawdUer(
                    feruyqCawdUserId: 2,
                    feruyqCawdEmail: "nvienad@gmail.com",
                    feruyqCawdPassword: "946545",
                    feruyqCawdUserName: "Miranda",
                    feruyqCawdAvatar: "bnunea_ava_2",
                    feruyqCawdAboutMe: "",
                    feruyqCawdFollowing: [],
                    feruyqCawdFans: [0],
                    feruyqCawdBlacklist: [],
                    feruyqCawdWalletBalance: 0,
                    feruyqCawdLikeWorks: []
                ),
                FeruyqCawdUer(
                    feruyqCawdUserId: 3,
                    feruyqCawdEmail: "zuw35a1d@gmail.com",
                    feruyqCawdPassword: "zbvue3545",
                    feruyqCawdUserName: "Raychen",
                    feruyqCawdAvatar: "bnunea_ava_3",
                    feruyqCawdAboutMe: "",
                    feruyqCawdFollowing: [],
                    feruyqCawdFans: [0],
                    feruyqCawdBlacklist: [],
                    feruyqCawdWalletBalance: 0,
                    feruyqCawdLikeWorks: []
                ),
                FeruyqCawdUer(
                    feruyqCawdUserId: 4,
                    feruyqCawdEmail: "birnlfa54@gmail.com",
                    feruyqCawdPassword: "xcnun581b",
                    feruyqCawdUserName: "Jiang",
                    feruyqCawdAvatar: "bnunea_ava_4",
                    feruyqCawdAboutMe: "",
                    feruyqCawdFollowing: [],
                    feruyqCawdFans: [0],
                    feruyqCawdBlacklist: [],
                    feruyqCawdWalletBalance: 0,
                    feruyqCawdLikeWorks: []
                )
            ]

            save(users, forKey: Keys.users)
        }
}

//User CRUD & 登录态
extension FaioStorageManager {

    func getUsers() -> [FeruyqCawdUer] {
        load([FeruyqCawdUer].self, forKey: Keys.users, default: [])
    }

    func saveUsers(_ users: [FeruyqCawdUer]) {
        save(users, forKey: Keys.users)
    }
    
    func getUserById(userId: Int) -> FeruyqCawdUer? {
        let allUsers = getUsers()
        // 查找第一个 userId 匹配的用户
        return allUsers.first { $0.feruyqCawdUserId == userId }
    }

    func updateUser(
        uid: Int,
        update: (FeruyqCawdUer) -> FeruyqCawdUer
    ) {
        var users = getUsers()
        guard let index = users.firstIndex(where: { $0.feruyqCawdUserId == uid }) else { return }
        users[index] = update(users[index])
        saveUsers(users)
    }

    // MARK: Login State
    func setCurrentUserId(_ uid: Int) {
        storage.set(uid, forKey: Keys.currentUserId)
    }

    func getCurrentUserId() -> Int {
        storage.integer(forKey: Keys.currentUserId)
    }
    
    /// - Returns: 登录成功返回用户，失败返回 nil
    func login(email: String, password: String) -> FeruyqCawdUer? {
        let users = getUsers()

        guard let user = users.first(where: {
            $0.feruyqCawdEmail == email &&
            $0.feruyqCawdPassword == password
        }) else {
            return nil
        }

        // 记录登录态
        setCurrentUserId(user.feruyqCawdUserId)
        return user
    }
}

//work
extension FaioStorageManager {

    private func initializeWorksIfNeeded() {
        guard storage.data(forKey: Keys.works) == nil else { return }
        
        let works: [WeianzVenvnWork] = [
            WeianzVenvnWork(
                weianzVenvnWorkId: 0,
                weianzVenvnCreatorId: 0,
                weianzVenvnTextContent: "Sydney Outdoor Movie Mov'in Bed",
                weianzVenvnImageListUrl: [
                    "fahdiwa_img_0",
                    "fahdiwa_img_1",
                    "fahdiwa_img_2"
                ],
                weianzVenvnDate: Date()),
            WeianzVenvnWork(
                weianzVenvnWorkId: 1,
                weianzVenvnCreatorId: 1,
                weianzVenvnTextContent: "Remembering an unforgettable movie theater date",
                weianzVenvnImageListUrl: [
                    "fahdiwa_img_3",
                    "fahdiwa_img_4"
                ],
                weianzVenvnDate: Date()),
            WeianzVenvnWork(
                weianzVenvnWorkId: 2,
                weianzVenvnCreatorId: 2,
                weianzVenvnTextContent: "New York Retro Art Cinema 🎬",
                weianzVenvnImageListUrl: [
                    "fahdiwa_img_5",
                    "fahdiwa_img_6",
                    "fahdiwa_img_7"
                ],
                weianzVenvnDate: Date()),
            WeianzVenvnWork(
                weianzVenvnWorkId: 3,
                weianzVenvnCreatorId: 3,
                weianzVenvnTextContent: "Catbook Abbotsford Convent Sunset Edition Outdoor Movie",
                weianzVenvnImageListUrl: [
                    "fahdiwa_img_8",
                    "fahdiwa_img_9"
                ],
                weianzVenvnDate: Date()),
            WeianzVenvnWork(
                weianzVenvnWorkId: 4,
                weianzVenvnCreatorId: 4,
                weianzVenvnTextContent: "Outdoor Movie Night in Los Angeles Parks: Romance Under the Starry Sky",
                weianzVenvnImageListUrl: [
                    "fahdiwa_img_10",
                ],
                weianzVenvnDate: Date())
        ]
        save(works, forKey: Keys.works)
    }

    func getWorks() -> [WeianzVenvnWork] {
        load([WeianzVenvnWork].self, forKey: Keys.works, default: [])
    }
    
    func getWorksNotBlock() -> [WeianzVenvnWork] {
        let allWorks = getWorks()
        let currentUserInfo = getUserById(userId: getCurrentUserId())
        
        // 用 $0 指代遍历的每个 work 元素
        return allWorks.filter {
            guard let blacklist = currentUserInfo?.feruyqCawdBlacklist else { return true }
            return !blacklist.contains($0.weianzVenvnCreatorId)
        }
    }
    
    func getWorkDetailById(workId: Int) -> WeianzVenvnWork? {
        let allWorks = getWorks()
        guard let workDetail = allWorks.first(where: {
            $0.weianzVenvnWorkId == workId
        }) else {
            return nil
        }
        
        return workDetail
    }

    func addWork(_ work: WeianzVenvnWork) {
        var works = getWorks()
        works.insert(work, at: 0)
        save(works, forKey: Keys.works)
    }
}

//Comment
extension FaioStorageManager {

    private func initializeCommentsIfNeeded() {
        guard storage.data(forKey: Keys.comments) == nil else { return }
        save([CBawialBMeiComment](), forKey: Keys.comments)
    }

    func getComments(for workId: Int) -> [CBawialBMeiComment] {
        load([CBawialBMeiComment].self, forKey: Keys.comments, default: [])
            .filter { $0.cBawialBMeiCommentId == workId }
    }

    func addComment(_ comment: CBawialBMeiComment) {
        var comments = load([CBawialBMeiComment].self, forKey: Keys.comments, default: [])
        comments.append(comment)
        save(comments, forKey: Keys.comments)
    }
}

//ChatRoom & Message
extension FaioStorageManager {

    private func initializeChatRoomsIfNeeded() {
        guard storage.data(forKey: Keys.chatRooms) == nil else { return }
        save([CneakzUwyahChatRoom](), forKey: Keys.chatRooms)
    }

    func getChatRooms() -> [CneakzUwyahChatRoom] {
        load([CneakzUwyahChatRoom].self, forKey: Keys.chatRooms, default: [])
    }

    private func initializeMessagesIfNeeded() {
        guard storage.data(forKey: Keys.messages) == nil else { return }
        save([NwuzawiGhrdcjsMessage](), forKey: Keys.messages)
    }

    func getMessages(roomId: Int) -> [NwuzawiGhrdcjsMessage] {
        load([NwuzawiGhrdcjsMessage].self, forKey: Keys.messages, default: [])
            .filter { $0.nwuzawiGhrdcjsMsgId == roomId }
    }

    func addMessage(_ msg: NwuzawiGhrdcjsMessage) {
        var messages = load([NwuzawiGhrdcjsMessage].self, forKey: Keys.messages, default: [])
        messages.append(msg)
        save(messages, forKey: Keys.messages)
    }
}

//底层通用存取（核心）
private extension FaioStorageManager {

    func save<T: Codable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            storage.set(data, forKey: key)
        }
    }

    func load<T: Codable>(
            _ type: T.Type,
            forKey key: String,
            default defaultValue: T
        ) -> T {
            guard
                let data = storage.data(forKey: key),
                let value = try? JSONDecoder().decode(type, from: data)
            else {
                return defaultValue
            }
            return value
        }
}
