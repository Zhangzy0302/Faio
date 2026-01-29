import SwiftUI

struct RecnxdjWorkDetail: View {
  @Binding var appPath: NavigationPath

  let recnxdjWorkId: Int

  @State private var recnInputText: String = ""
  @FocusState private var recnInputIsFocus: Bool

  @EnvironmentObject var workVM: FaioWorksViewModel
  @EnvironmentObject var commentVM: FaioCommentsViewModel
  @EnvironmentObject var userVM: FaioUserViewModel

  @State private var isPresented: Bool = false

  @State private var recoanBlockUserId: Int = 3366

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()

      if let vunladaCreatorInfo = workVM.getUserByCreatorId(
        creatorId: workVM.workDetail?.weianzVenvnCreatorId ?? 0)
      {
        VStack {
          AwicnalWnvTopBar(awicanlActions: {
            HStack(spacing: 8) {
              ZwnagIreujImage(
                zwnagIreujImageUrl: vunladaCreatorInfo.feruyqCawdAvatar, zwnagIreujWidth: 34,
                zwnagIreujHeight: 34, zwnagIreujIsCircle: true
              )
              .onTapGesture {
                appPath.append(AppRoute.userPage(userId: vunladaCreatorInfo.feruyqCawdUserId))
              }
              Text(vunladaCreatorInfo.feruyqCawdUserName)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            }
            Spacer()

            if workVM.workDetail?.weianzVenvnCreatorId != userVM.currentUser?.feruyqCawdUserId {
              if let workDetail = workVM.workDetail,
                workDetail.weianzVenvnCreatorId != userVM.currentUser?.feruyqCawdUserId
              {
                HStack(spacing: 16) {
                  TuryhajFollowButton(
                    turyFollowUserId: workDetail.weianzVenvnCreatorId,
                    turyWidth: 61,
                    turyHeight: 24,
                    turyTextColor: .white
                  )
                  Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                    .onTapGesture {
                      recoanBlockUserId = workDetail.weianzVenvnCreatorId
                      isPresented = true
                    }
                }
              }
            }

          }

          )
          ScrollView {
            if let workDetail: WeianzVenvnWork = workVM.workDetail {
              VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                  .frame(height: 480)
                  .overlay(content: {
                    WorkImagePager(images: workDetail.weianzVenvnImageListUrl)
                  })
                Text(workDetail.weianzVenvnTextContent)
                  .font(.system(size: 16))
                  .fontWeight(.bold)
                  .foregroundColor(.white)
                  .padding(.vertical, 20)

                // comment
                VStack(alignment: .leading) {
                  Text("\(commentVM.workCommentsNotBlock.count) Comments")
                    .font(.system(size: 16))
                    .fontWeight(.black)
                    .foregroundColor(Color(red: 1, green: 153 / 255, blue: 0))
                    .padding(.bottom, 20)
                  LazyVStack {
                    ForEach(commentVM.workCommentsNotBlock) { commentItem in
                      CommentRow(
                        comment: commentItem, appPath: $appPath, isPresented: $isPresented,
                        recoanBlockUserId: $recoanBlockUserId
                      )
                    }
                  }
                }.padding(.bottom, 20)
              }.padding(.horizontal, 20)
            }
          }
          RecnxjBottomBar(
            recnxdjWorkId: recnxdjWorkId, recnInputText: $recnInputText,
            recnInputIsFocus: $recnInputIsFocus)
        }
      } else {
        Text("Work not found")
      }
      BottomSheet(
        isPresented: $isPresented,
        content: {
          ZcnwinaReportBlockBottom(
            zcnwinaIsShow: $isPresented, appPath: $appPath, zcnwinaBlockUserId: recoanBlockUserId)
        })
    }.navigationBarHidden(true).onTapGesture {
      recnInputIsFocus = false
    }.onAppear {
      workVM.getWorkDetailByWorkId(workId: recnxdjWorkId)
      commentVM.getCommentsNotBlockByWorkId(workId: recnxdjWorkId)
    }
  }

  private struct RecnxjBottomBar: View {
    let recnxdjWorkId: Int
    @Binding var recnInputText: String
    @FocusState.Binding var recnInputIsFocus: Bool

    @State private var bottomSafe: CGFloat = 0
    @EnvironmentObject var workVM: FaioWorksViewModel
    @EnvironmentObject var commentVM: FaioCommentsViewModel
    @EnvironmentObject var userVM: FaioUserViewModel

    var body: some View {
      HStack {
        BawnbvTextField(
          placeholder: "Say somthing.....", text: $recnInputText, isFocused: $recnInputIsFocus,
          height: 40, verticalPadding: 9, cornerRadius: 40, keyboardSendAction: .send
        )
        .onSubmit {
          if recnInputText.isEmpty {
            return
          }
          commentVM.addCommentItem(
            commentItem: CBawialBMeiComment(
              cBawialBMeiCommentWorkId: recnxdjWorkId,
              cBawialBMeiCommentUserId: userVM.currentUser!.feruyqCawdUserId,
              cBawialBMeiCommentText: recnInputText, cBawialBMeiDate: Date()))
          commentVM.getCommentsNotBlockByWorkId(workId: recnxdjWorkId)
          recnInputText = ""
          recnInputIsFocus = false
        }
        if let recaUserInfo = userVM.currentUser {
          Button(action: {
            userVM.toggleWorkIsLiked(workId: recnxdjWorkId)
          }) {
            Circle()
              .fill(Color(red: 39 / 255, green: 36 / 255, blue: 39 / 255))
              .frame(width: 40)
              .overlay(content: {
                Image(
                  recaUserInfo.feruyqCawdLikeWorks.contains(recnxdjWorkId)
                    ? "vnzwa_icon_like" : "vnzwa_icon_like_un"
                )
                .resizable().frame(
                  width: 24, height: 24)
              })
          }
        }
      }.padding(.horizontal, 20)
        .padding(.top, 13)
        .readBottomSafeArea {
          value in bottomSafe = value
        }
        .padding(.bottom, bottomSafe + 18)
        .background(
          Rectangle()
            .fill(.black)
            .ignoresSafeArea(edges: .bottom)
        )
    }
  }

  private struct WorkImagePager: View {

    let images: [String]

    var body: some View {
      GeometryReader { geo in
        TabView {
          ForEach(images, id: \.self) { image in
            ZwnagIreujImage(
              zwnagIreujImageUrl: image,
              zwnagIreujWidth: geo.size.width,
              zwnagIreujHeight: 480
            )
            .cornerRadius(20)
          }
        }
        .frame(height: 480)
        .tabViewStyle(.page)
        .clipShape(RoundedRectangle(cornerRadius: 20))

      }
    }
  }

  struct CommentRow: View {

    let comment: CBawialBMeiComment
    @Binding var appPath: NavigationPath
    @EnvironmentObject var commentVM: FaioCommentsViewModel
    @EnvironmentObject var userVM: FaioUserViewModel
    @Binding var isPresented: Bool

    @Binding var recoanBlockUserId: Int

    var body: some View {
      HStack {
        if let recndxjCommentUserInfo = commentVM.getCommetUserInfo(
          userId: comment.cBawialBMeiCommentUserId)
        {
          ZwnagIreujImage(
            zwnagIreujImageUrl: recndxjCommentUserInfo.feruyqCawdAvatar, zwnagIreujWidth: 40,
            zwnagIreujHeight: 40, zwnagIreujIsCircle: true
          ).padding(.trailing, 8)
            .onTapGesture {
              appPath.append(AppRoute.userPage(userId: comment.cBawialBMeiCommentUserId))
            }
          VStack(alignment: .leading, spacing: 1) {
            Text(recndxjCommentUserInfo.feruyqCawdUserName)
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .foregroundColor(.white)
            Text(comment.cBawialBMeiCommentText)
              .font(.system(size: 12))
              .fontWeight(.regular)
              .foregroundColor(.white.opacity(0.7))
          }.padding(.trailing, 8)
          Spacer()
          if recndxjCommentUserInfo.feruyqCawdUserId != userVM.currentUser!.feruyqCawdUserId {
            Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
              .onTapGesture {
                recoanBlockUserId = recndxjCommentUserInfo.feruyqCawdUserId
                isPresented = true
              }
          }

        } else {
          Text("error")
        }

      }
    }
  }
}
