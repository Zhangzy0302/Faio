import SwiftUI

enum UwiqonbListType {
  case following
  case fans
  case blacklist
}

struct UwiqonbUserList: View {
  let uwiqnvListType: UwiqonbListType

  @EnvironmentObject var userVM: FaioUserViewModel

  private var uwiqonbzTitle: String {
    switch uwiqnvListType {
    case .following:
      return "Follow"
    case .fans:
      return "Fans"
    case .blacklist:
      return "Blacklist"
    }
  }

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar(awicanlCenterTitle: uwiqonbzTitle)
        if uwiqonbzUserList.isEmpty {
          XgkgaldEmptyDataPlaceholder(topPadding: 120)
        } else {
          ScrollView {
            LazyVStack {
              ForEach(
                uwiqonbzUserList,
                id: \.self
              ) { uid in
                UwiqonbUserRow(uwiqonUserId: uid) {
                  UwwiqActionButton(uid: uid, uwiqnvListType: uwiqnvListType)
                }

              }
            }.padding(.vertical, 20)
          }
        }

      }
    }.navigationBarHidden(true)
  }

  private var uwiqonbzUserList: [Int] {
    switch uwiqnvListType {
    case .following:
      return userVM.currentUser!.feruyqCawdFollowing
    case .fans:
      return userVM.currentUser!.feruyqCawdFans
    case .blacklist:
      return userVM.currentUser!.feruyqCawdBlacklist
    }
  }

  private struct UwwiqActionButton: View {

    let uid: Int
    let uwiqnvListType: UwiqonbListType
    @EnvironmentObject var userVM: FaioUserViewModel

    var body: some View {
      Group {
        if uwiqnvListType == .blacklist {
          FeqocnButton(
            feqocnText: "Cancel", feqocnWidth: 76, feqocnHeight: 24, feqocnFontSize: 11
          ) {
            userVM.toggleUserIsBlocked(blockUserId: uid)
          }
        } else {
          TuryhajFollowButton(turyFollowUserId: uid)
        }
      }
    }
  }

  struct UwiqonbUserRow<Button: View>: View {

    let uwiqonUserId: Int
    let uwionButton: () -> Button

    @EnvironmentObject var userVM: FaioUserViewModel

    init(
      uwiqonUserId: Int,
      @ViewBuilder uwionButton: @escaping () -> Button
    ) {
      self.uwiqonUserId = uwiqonUserId
      self.uwionButton = uwionButton
    }

    var uwiqonUser: FeruyqCawdUer? {
      return userVM.returnUserInfoById(userId: uwiqonUserId)
    }

    var body: some View {
      HStack {
        if let uwqonczsUser: FeruyqCawdUer = uwiqonUser {
          HStack(spacing: 13) {
            ZwnagIreujImage(
              zwnagIreujImageUrl: uwqonczsUser.feruyqCawdAvatar,
              zwnagIreujWidth: 60, zwnagIreujHeight: 60, zwnagIreujIsCircle: true
            )

            Text(uwqonczsUser.feruyqCawdUserName)
              .font(.system(size: 16))
              .fontWeight(.semibold)
              .foregroundColor(.white)
          }
        }

        Spacer()

        uwionButton()
      }
      .padding(.horizontal, 20)
    }
  }
}
