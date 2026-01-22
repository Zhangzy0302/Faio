import SwiftUI

struct CnawmnirPostWork: View {
#if DEBUG
    @ObserveInjection var forceRedraw
  #endif
    @State private var cnawmnirUserName: String = ""
    @State private var cnawnirUploadVideo: String = ""
    
    @FocusState private var cnawmnirNameFocus: Bool
    var body: some View{
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
                        Text("Copywriter")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        BawnbvTextField(placeholder: "Please enter", text: $cnawmnirUserName, isFocused: $cnawmnirNameFocus)
                    }.padding(.bottom, 20)
                    VStack(alignment: .leading, spacing: 12){
                        Text("Upload")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        ZStack{
                            Circle()
                                .fill(Color(red: 204/255, green: 204/255, blue: 204/255))
                                .frame(width: 56)
                                .overlay(content: {
                                    Image("vnzwa_icon_add")
                                })
                        }.frame(width: 148, height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                            )
                    }
                    Spacer()
                    FeqocnButton(feqocnText: "Save", action: {}).padding(.vertical, 20)
                }
            }.padding()
        }.navigationBarHidden(true).enableInjection()
    }
}
