import SwiftUI

struct IeujanEditInfo: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    @State private var ieujanUserName: String = ""
    @State private var ieujanAboutMe: String = ""
    
    @FocusState private var ieujanNameFocus: Bool
    @FocusState private var ieujanAboutMeFocus: Bool
    
    var body: some View {
        let _ = forceRedraw
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack{
                AwicnalWnvTopBar(awicanlCenterTitle: "Edit")
                VStack{
                    ZStack(alignment: .bottomTrailing){
                        Circle().frame(width: 135, height: 135)
                        Image("vnzwa_change_avatar").resizable().frame(width: 40,height: 40)
                    }.frame(width: 135, height: 135)
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text("Name")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        BawnbvTextField(placeholder: "Please enter", text: $ieujanUserName, isFocused: $ieujanNameFocus)
                    }
                    VStack(alignment: .leading, spacing: 12){
                        Text("Name")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        BawnbvTextField(placeholder: "Please enter", text: $ieujanAboutMe, isFocused: $ieujanAboutMeFocus)
                    }
                }
            }.padding()
        }.navigationBarHidden(true).enableInjection()
    }
}

#Preview {
    IeujanEditInfo()
}
