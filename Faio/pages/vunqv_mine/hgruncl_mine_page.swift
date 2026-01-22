import SwiftUI

struct HgrunclMinePage: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    
    enum HgruncUserPageRoute: Hashable {
        case setting
        case editInfo
    }
    @State private var path = NavigationPath()
    
    var body: some View {
        let _ = forceRedraw
        NavigationStack(path: $path){
            ZStack(alignment: .top){
                VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
                Rectangle().frame(height: 375).ignoresSafeArea(edges: .top)
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        HStack{
                            Text("Lyric").font(.system(size: 24))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Image("vnzwa_icon_edit").resizable().frame(width: 28,height: 28)
                                .onTapGesture {
                                    path.append(HgruncUserPageRoute.editInfo)
                                }
                        }.padding(.bottom, 6)
                        Text("A movie, a journey of soul.")
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.bottom, 22)
                        HStack{
                            HStack(spacing: 8){
                                Text("21").font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("Folloing").font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(0.5))
                            }.padding(.trailing, 30)
                            HStack(spacing: 8){
                                Text("21").font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("Folloing").font(.system(size: 12))
                                    .fontWeight(.regular)
                                    .foregroundColor(.white.opacity(0.5))
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
                            path.append(HgruncUserPageRoute.setting)
                        }
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.navigationDestination(for: HgruncUserPageRoute.self){route in
                switch route{
                case .setting:
                    MwaldjReiDaSetting()
                case .editInfo:
                    IeujanEditInfo()
                }
            }
        }.enableInjection()
    }
}

#Preview {
    HgrunclMinePage()
}
