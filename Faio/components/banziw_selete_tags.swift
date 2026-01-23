import SwiftUI

struct BanziwSelectTags: View {
    let banziwTitle: String
    let banziwTagsList: [String]
    @Binding var seletedTag: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(banziwTitle)
                .font(.system(size: 18))
                .fontWeight(.black)
                .foregroundColor(.white)
            WrapLayout(spacing: 12, lineSpacing: 12) {
                ForEach(banziwTagsList, id: \.self) {item in
                    Text(item)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .frame(height: 20)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(
                            Group {
                                if(seletedTag == item) {
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(VawinvTheme.FaioColor.gradientOrangeToYellow)
                                }else {
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(.white.opacity(0.3))
                                }
                            }
                        ).onTapGesture {
                            withAnimation(.easeOut(duration: 0.23), {
                                seletedTag = item
                            })
                        }
                }
            }
        }
    }
}
