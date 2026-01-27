import SwiftUI

struct HgrunclUserPage: View {
    @Binding var appPath: NavigationPath
    let hgruncUserId: Int
    let hgruncIsMinePage: Bool
    
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            Rectangle().frame(height: 375).ignoresSafeArea(edges: .top)
                .overlay{
                    ZwnagIreujImage(zwnagIreujImageUrl: userVM.userInfo?.feruyqCawdAvatar ?? "vnzwa_default_avatar", zwnagIreujHeight: 375)
                }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    HStack{
                        Text(userVM.userInfo?.feruyqCawdUserName ?? "").font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Image("vnzwa_icon_edit").resizable().frame(width: 28,height: 28)
                            .onTapGesture {
                                appPath.append(HgywaUserRoute.editInfo)
                            }
                    }.padding(.bottom, 6)
                    Text(userVM.userInfo?.feruyqCawdAboutMe ?? "")
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.bottom, 22)
                    HStack{
                        Button(action: {
                            appPath.append(HgywaUserRoute.userList(listType: .following))
                        }){
                            HStack(spacing: 8){
                                Text("\(userVM.userInfo?.feruyqCawdFollowing.count ?? 0)").font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("Folloing").font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }.padding(.trailing, 30)
                        Button(action: {
                            appPath.append(HgywaUserRoute.userList(listType: .fans))
                        }){
                            HStack(spacing: 8){
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
                    RoundedRectangle(cornerRadius: 24).fill(Color(red: 39/255, green: 39/255, blue: 39/255))
                ).padding(.horizontal, 20).padding(.top, 275).padding(.bottom, 24)
                
                VStack{
                    Text("Post")
                        .font(.system(size: 16))
                        .fontWeight(.black)
                        .foregroundStyle(Color(red: 1, green: 153/255, blue: 0))

                }.padding(.horizontal, 20)
            }
            HStack{
                Image("vnzwa_icon_setting").resizable()
                    .frame(width: 40, height: 40)
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        appPath.append(HgywaUserRoute.setting)
                    }
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }.onAppear{
            userVM.loadUserInfoByUid(uid: hgruncUserId)
        }
    }
}

