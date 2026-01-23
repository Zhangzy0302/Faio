import SwiftUI

struct EuenxzScriptResults: View {
    let euenxzTheme: String
    let euenxzStyle: String
    let euenxzCharacter: String
    let euenxzKeyWords: String
    
    var body: some View {
        ZStack(alignment: .top){
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack {
                AwicnalWnvTopBar()
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 39/255, green: 39/255, blue: 39/255))
                        .frame(height: 460)
                        .overlay(content: {
                            ScrollView {
                                Text("《The Quest for the Mysterious Realm》Characters:Lily: A brave and kind-hearted young woman.Max: Lily's loyal and adventurous friend.The Wise Elder: A wise old man who provides guidance.Scene 1: The Call to AdventureLocation: A small villageLily is walking through the village square when she notices a strange glow in the distance. She approaches the Wise Elder.Lily: \"Elder, what could that glow be?\"The Wise Elder: \"It is a sign, child. A mysterious realm awaits discovery. Only the brave and pure of heart can find it.\"")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            }.padding(16)
                        })
                        .padding(20)
                    Spacer()
                    FeqocnButton(feqocnText: "Save", action: {})
                        .padding(.bottom, 30)
                        .padding(.horizontal, 20)
                }
            }
        }.navigationBarHidden(true)
    }
}
