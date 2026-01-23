import SwiftUI

enum UwiqonbListType {
    case following
    case fans
    case blacklist
}

struct UwiqonbUserList: View {
    let uwiqnvListType: UwiqonbListType
    
    var body: some View {
        ZStack(alignment: .top) {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlCenterTitle: "Follow")
                ScrollView {
                    LazyVStack {
                        HStack {
                            HStack(spacing: 13) {
                                Circle().frame(width: 60, height: 60)
                                Text("wjcaa")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            FeqocnButton(feqocnText: "Follow", action: {})
                        }.padding(.horizontal, 20)
                    }.padding(.vertical, 20)
                }
            }
        }.navigationBarHidden(true)
    }
}
