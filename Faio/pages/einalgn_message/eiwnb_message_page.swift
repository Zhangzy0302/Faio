import SwiftUI

struct EiwnbMessagePage: View {
    
    @Binding var appPath: NavigationPath
    
    @EnvironmentObject var eiwnbChatVM: FaioChatViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(alignment: .bottomLeading){
                Rectangle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow).frame(width: 80, height: 12).cornerRadius(15)
                Text("Message").font(.system(size: 28))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0, x: 1, y: 2)
            }.padding(.leading, 20).padding(.top, 16).padding(.bottom, 30)
            
            ScrollView{
                LazyVStack{
                    ForEach(eiwnbChatVM.myChatRooms) {chatRoom in
                        Button(action: {
                            appPath.append(HgywaChatRoute.chatRoom(chatRoomId: chatRoom.cneakzUwyahRoomId))
                        }) {
                            HStack{
                                Circle().frame(width: 60).padding(.trailing, 12)
                                VStack(alignment: .leading, spacing: 4){
                                    Text("Sailor")
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold).foregroundColor(.white)
                                    Text("hello what are you doing？ ")
                                        .font(.system(size: 12))
                                        .fontWeight(.regular).foregroundColor(.white.opacity(0.5))
                                }
                                Spacer()
                                VStack{
                                    Text("2 mins ago")
                                        .font(.system(size: 10))
                                        .foregroundColor(.white.opacity(0.4))
                                }
                            }.padding(.horizontal, 20)
                        }
                        
                    }
                }
            }
        }.onAppear{
            eiwnbChatVM.getMyChatRooms()
        }
    }
}
