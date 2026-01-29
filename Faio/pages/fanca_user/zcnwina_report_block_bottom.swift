import SwiftUI

struct ZcnwinaReportBlockBottom: View {
  @Binding var zcnwinaIsShow: Bool
  @Binding var appPath: NavigationPath

  var body: some View {
    VStack(spacing: 20) {
      FeqocnButton(
        feqocnText: "Report",
        action: {
          zcnwinaIsShow = false
          appPath.append(AppRoute.reportPage)
        })
      FeqocnButton(
        feqocnText: "Shield", feqocnBgColorIsOrange: false, feqocnBgColor: .black,
        feqocnFontColor: .white,
        action: {

        })
      FeqocnButton(
        feqocnText: "Cancel", feqocnBgColorIsOrange: false,
        action: {
          zcnwinaIsShow = false
        })
    }.padding(.horizontal, 20)
      .padding(.bottom, 34)
  }
}
