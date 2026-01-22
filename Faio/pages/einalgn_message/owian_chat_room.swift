import SwiftUI

struct OwianChatRoom: View {
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
                        Image("vnzwa_icon_call_video").resizable().frame(width: 34, height: 34)
                        Image("vnzwa_icon_more").resizable().frame(width: 40, height: 40)
                    }
                }
                
                ScrollView {
                    VStack {
                        HStack {
                            Circle().frame(width: 40)
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}
