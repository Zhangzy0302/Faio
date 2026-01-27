import SwiftUI


struct NwuivalNwiHome: View {
    
    @Binding var appPath: NavigationPath
    
    enum NuwiType {
        case Trending
        case Foryou
        case Following
    }
    
    @State var nwuivalCurrentType: NuwiType = NuwiType.Trending
    
    @EnvironmentObject var userVM: FaioUserViewModel
    @EnvironmentObject var workVM: FaioWorksViewModel
    
    @State private var bottomSafeHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack(alignment: .leading){
                HStack {
                    ZStack(alignment: .bottomLeading){
                        Rectangle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow).frame(width: 80, height: 12).cornerRadius(15)
                        Text("Faio").font(.system(size: 28))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 0, x: 1, y: 2)
                    }
                    Spacer()
                    Circle().frame(width: 40, height: 40)
                        .overlay(content: {
                            ZwnagIreujImage(zwnagIreujImageUrl: userVM.currentUser?.feruyqCawdUserName ?? "",
                                            zwnagIreujWidth: 40,
                                            zwnagIreujHeight: 40,
                                            zwnagIreujIsCircle: true)
                        })
                }.padding(.horizontal, 20).padding(.top, 16)
                
                HStack(spacing: 15){
                    Rectangle().fill(LinearGradient(colors: [Color(red: 141/255, green: 88/255, blue: 253/255),
                                                             Color(red: 168/255, green: 37/255, blue: 163/255)],
                                                    startPoint: .top, endPoint: .bottom))
                        .frame(height: 68)
                        .cornerRadius(15)
                        .overlay(content: {
                            HStack(content: {
                                Text("Script \nWriting").font(.system(size: 16)).fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 0, x: 1, y: 2)
                                Spacer()
                                Image("vnzwa_script_writing").resizable().frame(width: 49, height: 58)
                            }).padding(.horizontal, 10)
                        })
                        .onTapGesture {
                            appPath.append(HgywaAiRoute.aiScriptWritingPresets)
                        }
                    Rectangle().fill(LinearGradient(colors: [Color(red: 41/255, green: 116/255, blue: 80/255),
                                                             Color(red: 47/255, green: 206/255, blue: 196/255)],
                                                    startPoint: .bottom, endPoint: .top))
                        .frame(height: 68)
                        .cornerRadius(15)
                        .overlay(content: {
                            HStack(content: {
                                Text("Character \nChat").font(.system(size: 16)).fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 0, x: 1, y: 2)
                                Spacer()
                                Image("vnzwa_character_chat").resizable().frame(width: 49, height: 58)
                            }).padding(.horizontal, 10)
                        })
                        .onTapGesture {
                            appPath.append(HgywaAiRoute.aiCharacterChatPresets)
                        }
                }.padding(.horizontal, 20)
                
                HStack(spacing: 20){
                    NuwivalTypeText(typeText: "Trending", type: .Trending, currentType: $nwuivalCurrentType)
                    NuwivalTypeText(typeText: "For you", type: .Foryou, currentType: $nwuivalCurrentType)
                    NuwivalTypeText(typeText: "Following", type: .Following, currentType: $nwuivalCurrentType)
                }.padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 16)
                
                GeometryReader{geo in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 12) {
                            ForEach(workVM.allWorks) { work in
                                VStack{
                                    ZwnagIreujImage(zwnagIreujImageUrl: work.weianzVenvnImageListUrl.first ?? "",
                                                    zwnagIreujWidth: 275, zwnagIreujHeight: geo.size.height - 98)
                                        .cornerRadius(20)
                                    
                                    VStack(alignment: .leading){
                                        if let maiwanUserInfo: FeruyqCawdUer = workVM.getUserByCreatorId(creatorId: work.weianzVenvnCreatorId) {
                                            HStack{
                                                ZwnagIreujImage(zwnagIreujImageUrl: maiwanUserInfo.feruyqCawdAvatar, zwnagIreujWidth: 34, zwnagIreujHeight: 34, zwnagIreujIsCircle: true)
                                                Text(maiwanUserInfo.feruyqCawdUserName).font(.system(size: 16)).fontWeight(.semibold).foregroundColor(.white)
                                                Spacer()
                                                FeqocnButton(feqocnText: "Follow", feqocnWidth: 76, feqocnHeight: 24, feqocnFontSize: 11, feqocnFontWeight: .semibold, action: {})
                                            }.padding(.bottom, 8)
                                        } else {
                                            HStack{
                                                Circle().frame(width: 34)
                                                Text("none").font(.system(size: 16)).fontWeight(.semibold).foregroundColor(.white)
                                                Spacer()
                                            }.padding(.bottom, 8)
                                        }
                                        
                                        Text(work.weianzVenvnTextContent)
                                            .font(.system(size: 16))
                                            .lineLimit(1)
                                            .foregroundColor(.white.opacity(0.7))
                                    }.padding(16).frame(height: 98)
                                }.frame(width: 275, height: geo.size.height)
                                    .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red: 39/255, green: 39/255, blue: 39/255))
                                        
                                    ).onTapGesture {
                                        appPath.append(HgywaWorkRoute.workDetail(workId: work.weianzVenvnWorkId))
                                    }
                                
                            }
                        }.frame(height: geo.size.height).padding(.horizontal, 20)
                    }.frame(maxHeight: .infinity)
                    .layoutPriority(1)
                }
                
                
            }.readBottomSafeArea{value in 
                bottomSafeHeight = value}
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 86 + bottomSafeHeight)
        }
    }
    
    struct NuwivalTypeText: View {
        let typeText: String
        let type: NuwiType
        @Binding var currentType: NuwiType
        
        var body: some View {
            VStack(spacing: 2){
                Text(typeText).font(.system(size: 16)).fontWeight(.heavy)
                    .foregroundColor(type == currentType ? .white : .white.opacity(0.4))
                if(type == currentType){
                    Rectangle().fill(LinearGradient(colors: [VawinvTheme.FaioColor.yellow, VawinvTheme.FaioColor.orange], startPoint: .leading, endPoint: .trailing))
                        .frame(width: 30, height: 6).cornerRadius(10)
                }
                
            }.frame(height: 32, alignment: .top).onTapGesture {
                withAnimation(.easeInOut(duration: 0.25)) {
                        currentType = type
                    }
            }
        }
    }
}

