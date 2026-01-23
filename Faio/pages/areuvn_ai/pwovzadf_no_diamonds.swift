import SwiftUI

struct PwovzadfNoDiamonds: View {
    @Binding var appPath: NavigationPath
    @Binding var pwovzaIsShowAlert: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack{
                Spacer()
                Image("vnzwa_diamond_grey").resizable().frame(width: 85, height: 85).padding(.bottom, 24)
                Text("Insufficient Coins")
                    .font(.system(size: 22))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.bottom, 34)
                FeqocnButton(feqocnText: "Recharge", action: {
                    pwovzaIsShowAlert = false
                    appPath.append(HgywaUserRoute.wallet)
                }).padding(.bottom, 20)
            }.padding(.horizontal, 20)
            
            Circle().fill(.black).frame(width: 40, height: 40)
                .overlay(content: {
                    Image("vnzwa_icon_close").resizable().frame(width: 20, height: 20)
                }).onTapGesture {
                    pwovzaIsShowAlert = false
                }.padding(12)
        }.frame(height: 292)
            .background(
                ZStack {
                    LinearGradient(colors: [VawinvTheme.FaioColor.yellow, VawinvTheme.FaioColor.orange], startPoint: .leading, endPoint: .trailing)
                    LinearGradient(colors: [.white, .white.opacity(0.3)], startPoint: .bottom, endPoint: .top)
                }
            )
            .cornerRadius(20)
    }
}
