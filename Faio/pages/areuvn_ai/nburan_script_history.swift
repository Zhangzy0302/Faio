import SwiftUI

struct NburanScriptHistory: View {
  @EnvironmentObject var moiveScriptHistoryVM: FaioMoiveScriptViewModel
  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar()
        ScrollView {
            if(moiveScriptHistoryVM.myHistory.isEmpty){
                XgkgaldEmptyDataPlaceholder(topPadding: 120)
            }else{
                LazyVStack(spacing: 20) {
                  ForEach(moiveScriptHistoryVM.myHistory) { scriptItem in
                    NburanScriptHistoryItem(nbvuarnScriptHistoryItem: scriptItem)
                  }
                }.padding(.top, 20)
                  .padding(.bottom, 40)
            }
          
        }
      }
    }.navigationBarHidden(true).onAppear {
      moiveScriptHistoryVM.getMyHistory()
    }
  }

  private struct NburanScriptHistoryItem: View {
    let nbvuarnScriptHistoryItem: MvjqyqzMvjqyqzHistory
    @EnvironmentObject var moiveScriptHistoryVM: FaioMoiveScriptViewModel
    var body: some View {
      VStack(alignment: .leading, spacing: 12) {
        Text(nbvuarnScriptHistoryItem.mvjqyqzHistoryDate.toString())
          .font(.system(size: 18))
          .fontWeight(.black)
          .foregroundColor(.white)
        HStack(spacing: 20) {
          Text(nbvuarnScriptHistoryItem.mvjqyqzHistoryText)
            .font(.system(size: 16))
            .lineLimit(2)
            .foregroundColor(.white)
          Button(action: {
            moiveScriptHistoryVM.deleteMyHistory(workId: nbvuarnScriptHistoryItem.id)
            moiveScriptHistoryVM.getMyHistory()
          }) {
            Circle().fill(Color(red: 1, green: 153 / 255, blue: 0).opacity(0.4)).frame(width: 40)
              .overlay {
                Image("vnzwa_icon_delete").resizable().frame(width: 20, height: 20)
              }
          }
        }.padding(.vertical, 20)
          .padding(.leading, 16)
          .padding(.trailing, 20)
          .frame(maxWidth: .infinity)
          .background(
            RoundedRectangle(cornerRadius: 20).fill(
              Color(red: 39 / 255, green: 39 / 255, blue: 39 / 255)))
      }.padding(.horizontal, 20)
    }
  }
}
