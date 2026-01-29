import SwiftUI

struct FruahzCharacterChatPreset: View {
    @Binding var appPath: NavigationPath
    
    private let fruahzCharacters: [String] = [
        "Brave",
        "Optimistic",
        "Smart",
        "Cunning",
        "Humorous"
    ]
    
    private let fruzhzChatDirection = [
        "Adventure",
        "Emotion",
        "Dream",
        "Skill",
        "Challenge"
    ]
    
    @State private var fruzhSeletedCharacter: String = ""
    @State private var fruzhSeletedDirection: String = ""
    
    @State private var fruzhInputMoive: String = ""
    @State private var fruzhInputCharacterName: String = ""
    @FocusState private var fruzhInputIsFocus_1: Bool
    @FocusState private var fruzhInputIsFocus_2: Bool
    
    @State private var baniznzShowNoDiamond = false
    @EnvironmentObject var userVM: FaioUserViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack {
                AwicnalWnvTopBar()
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        BanziwSelectTags(banziwTitle: "Character", banziwTagsList: fruahzCharacters, seletedTag: $fruzhSeletedCharacter)
                        BanziwSelectTags(banziwTitle: "Chat direction", banziwTagsList: fruzhzChatDirection, seletedTag: $fruzhSeletedDirection)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Movie")
                                .font(.system(size: 18))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            BawnbvTextField(placeholder: "Which movie would you like this character to appear in?", text: $fruzhInputMoive, isFocused: $fruzhInputIsFocus_1, height: 128)
                        }
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Character Name")
                                .font(.system(size: 18))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            BawnbvTextField(placeholder: "please enter", text: $fruzhInputCharacterName, isFocused: $fruzhInputIsFocus_2)
                        }
                        
                        Button(action: {
                            if(fruzhSeletedCharacter.isEmpty || fruzhzChatDirection.isEmpty){
                                FaioHUD.error("Please select movie character information and chat direction")
                                return
                            }
                            if(fruzhInputMoive.isEmpty || fruzhInputCharacterName.isEmpty){
                                FaioHUD.error("Please enter the movie character's experience and character name")
                            }
                            if(userVM.currentUser?.feruyqCawdWalletBalance ?? 0 > 600){
                                appPath.append(AppRoute.aiChatRoom(character: fruzhSeletedCharacter, chatDirection: fruzhSeletedDirection))
                            }
                            baniznzShowNoDiamond = true
                        }){
                            HStack(spacing: 8) {
                                Spacer()
                                Text("600")
                                    .font(.system(size: 16))
                                    .fontWeight(.black)
                                    .foregroundColor(.black)
                                Image("vnzwa_diamond").resizable().frame(width: 30, height: 30)
                                Text("Generate")
                                    .font(.system(size: 16))
                                    .fontWeight(.black)
                                    .foregroundColor(.black)
                                Spacer()
                                
                            }.frame(height: 52, alignment: .center).background(
                                RoundedRectangle(cornerRadius: 100)
                                    .fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                            )
                        }
                    }.padding(.horizontal, 20)
                        .padding(.vertical, 20)
                }
            }
            CustomDialog(isPresented: $baniznzShowNoDiamond) {
                PwovzadfNoDiamonds(appPath: $appPath, pwovzaIsShowAlert: $baniznzShowNoDiamond)
                        .padding(.horizontal, 24)
                }
        }.navigationBarHidden(true).onTapGesture {
            fruzhInputIsFocus_1 = false
            fruzhInputIsFocus_2 = false
        }
    }
}
