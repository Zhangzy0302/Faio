import SwiftUI

enum UwiqonbListType {
    case following
    case fans
    case blacklist
}

struct UwiqonbUserList: View {
    let uwiqnvListType: UwiqonbListType
    
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlCenterTitle: "Follow")
                ScrollView {
                    LazyVStack {
                        ForEach(uwiqnvListType == .blacklist ?
                                userVM.currentUser!.feruyqCawdBlacklist : uwiqnvListType == .following ?
                                userVM.currentUser!.feruyqCawdFollowing : userVM.currentUser!.feruyqCawdFans, id: \.self){ uid in
                            UwiqonbUserRow(uwiqonUserId: uid){
                                FeqocnButton(feqocnText: "Follow", feqocnWidth: 76, feqocnHeight: 24, feqocnBgColorIsOrange: true, feqocnBgColor: Color(red: 85/255, green: 85/255,blue: 85/255), feqocnFontSize: 11, feqocnFontWeight: .semibold, feqocnFontColor: .white, action: {
                                    
                                })
                            }
                            
                        }
                    }.padding(.vertical, 20)
                }
            }
        }.navigationBarHidden(true)
    }
    
    struct UwiqonbUserRow<Button: View>: View {

        let uwiqonUserId: Int
        let uwionButton: () -> Button

        init(
            uwiqonUserId: Int,
            @ViewBuilder uwionButton: @escaping () -> Button
        ) {
            self.uwiqonUserId = uwiqonUserId
            self.uwionButton = uwionButton
        }

        var body: some View {
            HStack {
                HStack(spacing: 13) {
                    Circle()
                        .frame(width: 60, height: 60)

                    Text("wjcaa")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }

                Spacer()

                uwionButton()
            }
            .padding(.horizontal, 20)
        }
    }
}
