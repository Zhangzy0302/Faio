import SwiftUI

struct OwianChatRoom: View {
    @Binding var appPath: NavigationPath
    
    @State private var owianBottomHeight: CGFloat = 0
    @State private var owianInputText: String = ""
    @FocusState private var owianInputIsFocus: Bool
    
    @State private var owianIsShowBlock: Bool = false
    
    var body: some View {
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar() {
                    HStack(spacing: 12){
                        Circle().frame(width: 40)
                        Text("Lyric")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }.padding(.leading, 16)
                    Spacer()
                    HStack(spacing: 16){
                        Button(action: {
                            appPath.append(HgywaChatRoute.videoCalling)
                        }) {
                            Image("vnzwa_icon_call_video").resizable().frame(width: 34, height: 34)
                        }
                        Button(action: {
                            owianIsShowBlock = true
                        }){
                            Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                        }
                    }
                }
                
                ScrollView {
                    VStack {
                        HStack(alignment: .top, spacing: 12) {
                            Circle().frame(width: 40)
                            Text("Hey, dear friend! I am xxx")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(12)
                                .frame(maxWidth: 220)
                                .background(
                                    UnevenRoundedRectangle(
                                                topLeadingRadius: 0,
                                                bottomLeadingRadius: 15,
                                                bottomTrailingRadius: 15,
                                                topTrailingRadius: 15
                                            )
                                            .fill(Color.white)
                                )
                            Spacer()
                        }
                        HStack(alignment: .top, spacing: 12) {
                            Spacer()
                            Text("Hey, dear friend! I am xxx")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding(12)
                                .frame(maxWidth: 220)
                                .background(
                                    UnevenRoundedRectangle(
                                                topLeadingRadius: 15,
                                                bottomLeadingRadius: 15,
                                                bottomTrailingRadius: 15,
                                                topTrailingRadius: 0
                                            )
                                    .fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                                )
                            Circle().frame(width: 40)
                        }
                    }.padding(20)
                }
                HStack{
                    BawnbvTextField(placeholder: "Say somthing.....", text: $owianInputText, isFocused: $owianInputIsFocus, height: 40, verticalPadding: 9, cornerRadius: 40)
                    
                }.padding(.horizontal, 20).padding(.top, 13)
                    .readBottomSafeArea { value in
                        owianBottomHeight = value
                    }
                    .padding(.bottom, owianBottomHeight + 18)
                    .background(Rectangle().fill(.black))
                    .ignoresSafeArea(edges: .bottom)
            }
            
            BottomSheet(isPresented: $owianIsShowBlock) {
                ZcnwinaReportBlockBottom(zcnwinaIsShow: $owianIsShowBlock, appPath: $appPath)
            }
        }.navigationBarHidden(true)
    }
}
