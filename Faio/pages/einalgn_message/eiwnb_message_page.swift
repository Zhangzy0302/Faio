import SwiftUI

struct EiwnbMessagePage: View {
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack(alignment: .bottomLeading){
                Rectangle().fill(VawinvTheme.FaioColor.gradientOrangeToYellow).frame(width: 80, height: 12).cornerRadius(15)
                Text("Message").font(.system(size: 28))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0, x: 1, y: 2)
            }.padding(.leading, 20).padding(.top, 16)
            
            ScrollView{
                LazyVStack{
                    HStack{
                        Circle().frame(width: 60).padding(.trailing, 12)
                        VStack(spacing: 4){
                            Text("Sailor")
                                .font(.system(size: 16))
                                .fontWeight(.semibold).foregroundColor(.white)
                            Text("hello what are you doing？ ")
                                .font(.system(size: 12))
                                .fontWeight(.regular).foregroundColor(.white.opacity(0.5))
                        }
                        Spacer()
                        VStack{
                            Text("2 mins ago")
                                .font(.system(size: 10))
                                .foregroundColor(.white.opacity(0.4))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EiwnbMessagePage()
}
