import SwiftUI

struct HgrunclMinePage: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Lyric").font(.system(size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.bottom, 6)
            }.padding(.horizontal, 16).padding(.top, 16).padding(.bottom, 24).background(
                RoundedRectangle(cornerRadius: 24).fill(Color(red: 39/255, green: 39/255, blue: 39/255))
            )
        }
    }
}

#Preview {
    HgrunclMinePage()
}
