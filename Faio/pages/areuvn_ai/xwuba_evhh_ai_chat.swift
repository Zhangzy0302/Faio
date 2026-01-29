import SwiftUI

struct XwubaEvhhAiChat: View {
  let xwubaCharacter: String
  let xwubaChatDirection: String

  @State private var xwubaEvhhInput: String = ""
  @FocusState private var xwubaEvhhIsFocused: Bool

  @State private var owianBottomHeight: CGFloat = 0

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar()
        ScrollView {
          VStack {
            VStack {
              HStack(alignment: .top, spacing: 12) {
                Circle().frame(width: 40)
                Text("Hey, dear friend! I am xxx")
                  .font(.system(size: 16))
                  .foregroundColor(.black)
                  .padding(12)
                  .frame(maxWidth: 220)
                  .background(
                    UnevenRoundedRectangle(
                      topLeadingRadius: 0,
                      bottomLeadingRadius: 15,
                      bottomTrailingRadius: 15,
                      topTrailingRadius: 15
                    )
                    .fill(Color.white)
                  )
                Spacer()
              }
              HStack(alignment: .top, spacing: 12) {
                Spacer()
                Text("Hey, dear friend! I am xxx")
                  .font(.system(size: 16))
                  .foregroundColor(.black)
                  .padding(12)
                  .frame(maxWidth: 220)
                  .background(
                    UnevenRoundedRectangle(
                      topLeadingRadius: 15,
                      bottomLeadingRadius: 15,
                      bottomTrailingRadius: 15,
                      topTrailingRadius: 0
                    )
                    .fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                  )
                Circle().frame(width: 40)
              }
            }.padding(20)
          }
        }
        HStack {
          BawnbvTextField(
            placeholder: "Say somthing.....", text: $xwubaEvhhInput, isFocused: $xwubaEvhhIsFocused,
            height: 40, verticalPadding: 9, cornerRadius: 40, keyboardSendAction: .send)

        }.padding(.horizontal, 20).padding(.top, 13)
          .readBottomSafeArea { value in
            owianBottomHeight = value
          }
          .padding(.bottom, owianBottomHeight + 18)
          .background(Rectangle().fill(.black))
          .ignoresSafeArea(edges: .bottom)
      }
    }.onTapGesture {
      xwubaEvhhIsFocused = false
    }.navigationBarHidden(true)
  }
}
