import SwiftUI

struct TuryhajFollowButton: View {
  let turyFollowUserId: Int
  @EnvironmentObject var userVM: FaioUserViewModel
  @EnvironmentObject var workVM: FaioWorksViewModel
  var turyWidth: CGFloat = 76
  var turyHeight: CGFloat = 24
  var turyFontSize: CGFloat = 11
  var turyTextColor: Color = .black

  var body: some View {
    let cnzadjIsFollowed = userVM.currentUser!.feruyqCawdFollowing.contains(turyFollowUserId)
    FeqocnButton(
      feqocnText: cnzadjIsFollowed ? "Unfollow" : "Follow", feqocnWidth: turyWidth,
      feqocnHeight: turyHeight, feqocnBgColorIsOrange: !cnzadjIsFollowed,
      feqocnBgColor: Color(red: 85 / 255, green: 85 / 255, blue: 85 / 255),
      feqocnFontSize: turyFontSize, feqocnFontWeight: .semibold,
      feqocnFontColor: !cnzadjIsFollowed ? turyTextColor : .white,
      action: {
        userVM.toggleUserIsFollowed(followUserId: turyFollowUserId)
        workVM.getMyFollowingWorks()
      })
  }
}
