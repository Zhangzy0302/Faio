import SwiftUI

struct HgrunclUserPage: View {
  @Binding var appPath: NavigationPath
  let hgruncUserId: Int
  let hgruncIsMinePage: Bool

  @EnvironmentObject var userVM: FaioUserViewModel
  @EnvironmentObject var workVM: FaioWorksViewModel

  @State private var hgrunclIsShwoBlock: Bool = false

  @State private var bottomPadding: CGFloat = 0

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      ZStack(alignment: .bottom) {
        ScrollView {
          ZStack(alignment: .top) {
            Rectangle().fill(.white.opacity(0)).frame(height: 375)
              .background {
                ZwnagIreujImage(
                  zwnagIreujImageUrl: userVM.userInfo?.feruyqCawdAvatar ?? "vnzwa_default_avatar",
                  zwnagIreujHeight: 375)
              }.ignoresSafeArea(edges: .top)

            VStack(alignment: .leading) {
              VStack(alignment: .leading) {
                HStack {
                  Text(userVM.userInfo?.feruyqCawdUserName ?? "").font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                  Spacer()
                  Image("vnzwa_icon_edit").resizable().frame(width: 28, height: 28)
                    .onTapGesture {
                      appPath.append(AppRoute.editInfo)
                    }
                }.padding(.bottom, 6)
                Text(userVM.userInfo?.feruyqCawdAboutMe ?? "")
                  .foregroundColor(.white.opacity(0.5))
                  .padding(.bottom, 22)
                HStack {
                  Button(action: {
                    appPath.append(AppRoute.userList(listType: .following))
                  }) {
                    HStack(spacing: 8) {
                      Text("\(userVM.userInfo?.feruyqCawdFollowing.count ?? 0)").font(
                        .system(size: 16)
                      )
                      .fontWeight(.semibold)
                      .foregroundColor(.white)
                      Text("Folloing").font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(.white.opacity(0.5))
                    }
                  }.padding(.trailing, 30)
                  Button(action: {
                    appPath.append(AppRoute.userList(listType: .fans))
                  }) {
                    HStack(spacing: 8) {
                      Text("\(userVM.userInfo?.feruyqCawdFans.count ?? 0)").font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                      Text("Folloing").font(.system(size: 12))
                        .fontWeight(.regular)
                        .foregroundColor(.white.opacity(0.5))
                    }
                  }
                }

              }.padding(.horizontal, 16).padding(.top, 16).padding(.bottom, 24).background(
                RoundedRectangle(cornerRadius: 24).fill(
                  Color(red: 39 / 255, green: 39 / 255, blue: 39 / 255))
              ).padding(.horizontal, 20).padding(.top, 275).padding(.bottom, 24)

              VStack(alignment: .leading) {
                HStack {
                  Text("Post")
                    .font(.system(size: 16))
                    .fontWeight(.black)
                    .foregroundStyle(Color(red: 1, green: 153 / 255, blue: 0))
                    .padding(.bottom, 20)
                  Spacer()
                }

                hgruncGridUserWorks(hgaljfMyWorks: workVM.userWorks, appPath: $appPath)
              }.padding(.horizontal, 20)
                .padding(.bottom, 70)
            }
          }
        }.ignoresSafeArea()

        if !hgruncIsMinePage && hgruncUserId != userVM.currentUser?.feruyqCawdUserId {
          HStack(spacing: 15) {
            FeqocnButton(feqocnText: "Follow", feqocnWidth: .infinity, feqocnHeight: 40) {}
            FeqocnButton(
              feqocnText: "Chat", feqocnWidth: .infinity, feqocnHeight: 40,
              feqocnBgColorIsOrange: false
            ) {}
          }.padding(.horizontal, 20)
            .readBottomSafeArea { value in
              bottomPadding = value
            }
            .padding(.top, 12)
            .padding(.bottom, bottomPadding + 12)
            .background(
              Rectangle().fill(Color(red: 12 / 255, green: 12 / 255, blue: 12 / 255))
                .ignoresSafeArea()
            )
        }
      }
      Group {
        if hgruncIsMinePage {
          HStack {
            Image("vnzwa_icon_setting").resizable()
              .frame(width: 40, height: 40)
              .padding(.top, 16)
              .padding(.trailing, 20)
              .onTapGesture {
                appPath.append(AppRoute.setting)
              }
          }.frame(maxWidth: .infinity, alignment: .trailing)
        } else {
          AwicnalWnvTopBar {
            if hgruncUserId != userVM.currentUser?.feruyqCawdUserId {
              HStack {
                Spacer()
                HStack(spacing: 16) {
                  Button(action: {
                    appPath.append(AppRoute.videoCalling)
                  }) {
                    Image("vnzwa_icon_call_video").resizable().frame(width: 34, height: 34)
                  }
                  Button(action: {
                    hgrunclIsShwoBlock = true
                  }) {
                    Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                  }
                }
              }
            }
          }
        }
      }
      BottomSheet(isPresented: $hgrunclIsShwoBlock) {
        ZcnwinaReportBlockBottom(zcnwinaIsShow: $hgrunclIsShwoBlock, appPath: $appPath)
      }
    }.onAppear {
      userVM.getUserInfoByUid(uid: hgruncUserId)
      workVM.getWorksByUserId(userId: hgruncUserId)
    }.navigationBarHidden(true)
  }

  struct hgruncGridUserWorks: View {
    var hgaljfMyWorks: [WeianzVenvnWork]
    @Binding var appPath: NavigationPath

    let columns: [GridItem] = [
      GridItem(.flexible()),
      GridItem(.flexible()),
    ]

    var body: some View {
      LazyVGrid(columns: columns) {
        ForEach(hgaljfMyWorks) { item in
          ZwnagIreujImage(
            zwnagIreujImageUrl: item.weianzVenvnImageListUrl.first ?? "",
            zwnagIreujWidth: .infinity,
            zwnagIreujHeight: 220
          )
          .cornerRadius(20)
          .onTapGesture {
            appPath.append(AppRoute.workDetail(workId: item.weianzVenvnWorkId))
          }

        }
      }
    }
  }
}
