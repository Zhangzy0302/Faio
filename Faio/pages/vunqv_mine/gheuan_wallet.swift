import SwiftUI

struct GhueanWallet: View {
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack {
                AwicnalWnvTopBar()
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My Gems")
                                .font(.system(size: 18))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(.trailing, 16)
                            Image("vnzwa_diamond").resizable().frame(width: 20, height: 20)
                            Text("\(userVM.currentUser?.feruyqCawdWalletBalance ?? 0)")
                                .font(.system(size: 14))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .padding(.leading, 8)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 34)
                }
            }
        }.navigationBarHidden(true)
    }
}
