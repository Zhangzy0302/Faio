import SwiftUI

struct EuenxzScriptResults: View {
  let euenxzTheme: String
  let euenxzStyle: String
  let euenxzCharacter: String
  let euenxzKeyWords: String

  @State private var euenxzScript: String = ""
  @State private var euenxIsLoading: Bool = true
  @State private var wqinfIsSaved: Bool = false
  @EnvironmentObject var eanacwScriptVM: FaioMoiveScriptViewModel

  func enenxzAiCreateScript() async {
    euenxIsLoading = true
    await delay(2.5)  // 模拟网络/AI请求延迟
    euenxIsLoading = false

    // 获取所有还没显示过的索引
    let remainingIndexes = venzcjaScritpList.indices.filter { !venzhwIsShow.contains($0) }

    // 如果全部都显示过了，重置
    let chosenIndex: Int
    if remainingIndexes.isEmpty {
      venzhwIsShow = []
      chosenIndex = Int.random(in: venzcjaScritpList.indices)
    } else {
      chosenIndex = remainingIndexes.randomElement()!
    }

    // 记录已显示
    venzhwIsShow.append(chosenIndex)

    // 更新脚本
    euenxzScript = venzcjaScritpList[chosenIndex]
  }

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()

      VStack {
        AwicnalWnvTopBar()

        VStack {
          // 卡片
          ZStack {
            RoundedRectangle(cornerRadius: 20)
              .fill(Color(red: 39 / 255, green: 39 / 255, blue: 39 / 255))

            if !euenxIsLoading {
              ScrollView {
                Text(euenxzScript)
                  .font(.system(size: 14))
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .padding(16)
            } else {
              HStack {
                Spacer()
                ProgressView()
                  .progressViewStyle(.circular)
                  .scaleEffect(2)
                  .tint(.white)
                Spacer()
              }
            }
          }
          .frame(maxWidth: .infinity)
          .frame(height: 460)
          .padding(.horizontal, 20)

          Spacer()
          if wqinfIsSaved {
            FeqocnButton(
              feqocnText: "Save",
              action: {
                if !wqinfIsSaved {
                  wqinfIsSaved = true
                  eanacwScriptVM.addMyHistory(euenxzScript)
                  FaioHUD.success("Saved successfully")
                }
              }
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
          }

        }
      }
      .onAppear {
        Task {
          await enenxzAiCreateScript()
        }
      }
    }
    .navigationBarHidden(true)
  }
}
