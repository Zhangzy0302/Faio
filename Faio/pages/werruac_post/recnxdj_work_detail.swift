import SwiftUI

struct RecnxdjWorkDetail: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    
    @Binding var appPath: NavigationPath
    
    @State private var recnInputText: String = ""
    @FocusState private var recnInputIsFocus: Bool
    
    @State private var bottomSafe: CGFloat = 0
    
    var body: some View {
        let _ = forceRedraw
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlActions: {
                    HStack(spacing: 8){
                        Circle().frame(width: 34)
                        Text("Lyric")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    HStack(spacing: 16){
                        FeqocnButton(feqocnText: "Follow", feqocnWidth: 61,feqocnHeight: 24, feqocnFontSize: 11,feqocnFontWeight: .semibold,feqocnFontColor: .white, action: {})
                        Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                    }
                }
                
                )
                ScrollView{
                    VStack(alignment: .leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 480)
                            .overlay(content: {
                                ZStack{
                                    Image("vnzwa_icon_play").resizable().frame(width: 60, height: 60)
                                }
                            })
                        Text("Finally found people who get my movie passion. So happy to have these friends.")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                        
                        // comment
                        VStack(alignment: .leading){
                            Text("33 Comments")
                                .font(.system(size: 16))
                                .fontWeight(.black)
                                .foregroundColor(Color(red: 1, green: 153/255, blue: 0))
                                .padding(.bottom, 20)
                            HStack{
                                Circle().frame(width: 40).padding(.trailing, 8)
                                VStack(alignment: .leading, spacing: 1){
                                    Text("Tom")
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("Wow，pretty~")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular)
                                        .foregroundColor(.white.opacity(0.7))
                                }.padding(.trailing, 8)
                                Spacer()
                                Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                            }
                        }.padding(.bottom, 20)
                    }.padding(.horizontal, 20)
                }
                HStack{
                    BawnbvTextField(placeholder: "Say somthing.....", text: $recnInputText, isFocused: $recnInputIsFocus, height: 40, verticalPadding: 9, cornerRadius: 40)
                    Circle()
                        .fill(Color(red: 39/255, green: 36/255, blue: 39/255))
                        .frame(width: 40)
                        .overlay(content: {
                            Image("vnzwa_icon_like_un").resizable().frame(width: 24, height: 24)
                        })
                }.padding(.horizontal, 20).padding(.top, 13)
                    .readBottomSafeArea { value in
                        bottomSafe = value
                    }
                    .padding(.bottom, bottomSafe + 18)
                    .background(Rectangle().fill(.black))
                    .ignoresSafeArea(edges: .bottom)
            }
        }.navigationBarHidden(true).ignoresSafeArea(edges: .bottom).onTapGesture {
            recnInputIsFocus = false
        }.enableInjection()
    }
}

#Preview {
    RecnxdjWorkDetail_PreviewWrapper()
}
struct RecnxdjWorkDetail_PreviewWrapper: View {
    @State private var path = NavigationPath()

    var body: some View {
        RecnxdjWorkDetail(appPath: $path)
    }
}
