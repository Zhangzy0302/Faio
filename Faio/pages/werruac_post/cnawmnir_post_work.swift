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
                ScrollView {
                    VStack(alignment: .leading){
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
                                        Image("vnzwa_icon_add").resizable().frame(width: 20, height: 20)
                                    })
                            }.frame(width: 148, height: 200)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                )
                        }
                        
                    }.padding(.top, 20)
                }
                Spacer()
                FeqocnButton(feqocnText: "Post", action: {}).padding(.vertical, 20).padding(.horizontal, 20)
            }.padding()
        }.navigationBarHidden(true).onTapGesture {
            cnawmnirNameFocus = false
        }.enableInjection()
    }
}
