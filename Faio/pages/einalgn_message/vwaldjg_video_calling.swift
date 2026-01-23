import SwiftUI

struct VwaldjgVideoCalling: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Rectangle().fill(.black.opacity(0.5)).ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 24) {
                    Text("Calling...")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    Circle().fill(Color(red: 1, green: 87/255, blue: 51/255))
                        .frame(width: 54, height: 54)
                        .overlay(){
                            Image("vnzwa_quit_call").resizable().frame(width: 34, height: 34)
                        }.onTapGesture {
                            dismiss()
                        }
                }.padding(.bottom, 60)
            }
        }.navigationBarHidden(true)
    }
}
