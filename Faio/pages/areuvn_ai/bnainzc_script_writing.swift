import SwiftUI

struct BnainzcScriptWriting: View {
    @Binding var appPath: NavigationPath
    
    private let bnainzMovieTheme = ["Adventure", "Romance", "Sci-fi", "Suspense", "History", "Fantasy"]
    private let bnainzMovieStyle = ["Drama", "Comedy", "Action", "Sci-fi", "Romance"]
    private let bnainzCharacter = ["Brave", "kind", "Smart", "Cunning", "Humorous"]
    
    @State private var bnainzSeletedTheme: String = ""
    @State private var bnainzSeletedStyle: String = ""
    @State private var bnainzSeletedCharacter: String = ""
    
    @State private var baninzInputKeywords: String = ""
    @FocusState private var baninzInputKeywordsIsFocused: Bool
    
    @State private var baniznzShowNoDiamond = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            VStack {
                AwicnalWnvTopBar() {
                    HStack {
                        Spacer()
                        Image("vnzwa_history").resizable().frame(width: 30, height: 30)
                    }
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        BanziwSelectTags(banziwTitle: "Movie Theme", banziwTagsList: bnainzMovieTheme, seletedTag: $bnainzSeletedTheme)
                        BanziwSelectTags(banziwTitle: "Movie style", banziwTagsList: bnainzMovieStyle, seletedTag: $bnainzSeletedStyle)
                        BanziwSelectTags(banziwTitle: "Character", banziwTagsList: bnainzCharacter, seletedTag: $bnainzSeletedCharacter)
                        VStack(alignment: .leading, spacing: 12) {
                            Text("keywords")
                                .font(.system(size: 18))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            BawnbvTextField(placeholder: "Please enter some keywords of your ideas for the movie script...", text: $baninzInputKeywords, isFocused: $baninzInputKeywordsIsFocused, height: 128)
                        }
                        Button(action: {
                            appPath.append(
                                HgywaAiRoute.aiScriptWritingResult(
                                    theme: bnainzSeletedTheme,
                                    style: bnainzSeletedStyle,
                                    character: bnainzSeletedCharacter,
                                    keywords: baninzInputKeywords))
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
                        
                    }.padding(.horizontal, 20).padding(.vertical, 20)
                }
            }
            CustomDialog(isPresented: $baniznzShowNoDiamond) {
                PwovzadfNoDiamonds(appPath: $appPath, pwovzaIsShowAlert: $baniznzShowNoDiamond)
                        .padding(.horizontal, 24)
                }
        }.navigationBarHidden(true).onTapGesture {
            baninzInputKeywordsIsFocused = false
        }
    }
}
