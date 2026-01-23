import SwiftUI

struct NinzvnReportPage: View {
    
    private let ninzvnReportTypes = [
        "Harassment",
        "Malicious fraud",
        "Pornography",
        "Malicious insults",
        "False Information"
    ]
    @State private var ninzvnReportSeletType: String = ""
    
    @State private var ninzvnInput: String = ""
    @FocusState private var ninzvnIsFocus: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
            
            VStack {
                BanziwSelectTags(banziwTitle: "Report Type", banziwTagsList: ninzvnReportTypes, seletedTag: $ninzvnReportSeletType)
                    .padding(.bottom, 30).padding(.top, 25)
                
                BawnbvTextField(placeholder: "Supplementary description (optional)", text: $ninzvnInput, isFocused: $ninzvnIsFocus, height: 128)
                Spacer()
                FeqocnButton(feqocnText: "Submit", action: {
                    dismiss()
                }).padding(.bottom, 20)
            }.padding(.horizontal, 20)
        }.navigationBarHidden(true).onTapGesture {
            ninzvnIsFocus = false
        }
    }
}
