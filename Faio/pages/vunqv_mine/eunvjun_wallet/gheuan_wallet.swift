import StoreKit
import SwiftUI

struct GhueanWallet: View {
  @EnvironmentObject var userVM: FaioUserViewModel
  @EnvironmentObject var iapManager: IAPManager

  private let gahwColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar()
        VStack(alignment: .leading) {
          HStack {
            Text("My Gems")
              .font(.system(size: 18))
              .fontWeight(.black)
              .foregroundColor(.white)
              .padding(.trailing, 16)
            Image("vnzwa_diamond").resizable().frame(width: 20, height: 20)
            Text("\(userVM.currentUser?.feruyqCawdWalletBalance ?? 0)")
              .font(.system(size: 14))
              .fontWeight(.black)
              .foregroundColor(.white)
              .padding(.leading, 8)
          }.padding(.top, 20)
          ScrollView {
            LazyVGrid(columns: gahwColumns, spacing: 15) {
              ForEach(ghuencziwProducts, id: \.beuaxjcaiKeyId) { gem in
                Button(action: {
                  Task {
                    await iapManager.recharge(gem)
                  }
                }) {
                  COeuaGemWalletItem(gem: gem)
                }
              }
            }.padding(.bottom, 34)
          }
        }.padding(.horizontal, 20)

      }
      // loading 遮罩
      if iapManager.isPurchasing {
        Color.black.opacity(0.5)
          .edgesIgnoringSafeArea(.all)
          .overlay(
            VStack(spacing: 16) {
              ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.4)
                .tint(.white)

              Text("Loading...")
                .foregroundColor(.white)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .background(
              RoundedRectangle(cornerRadius: 20)
                .fill(.black.opacity(0.8))
                .frame(width: 100, height: 100)
                .clipped())
          )
          .transition(.opacity)
      }

    }.navigationBarHidden(true)
      .task {
        await iapManager.fetchProducts()

      }
  }

  struct COeuaGemWalletItem: View {
    let gem: BeuaxjcaiProduct

    var body: some View {
      VStack {
        Image("vnzwa_diamond")
          .resizable()
          .frame(width: 34, height: 34)
          .padding(.bottom, 5)
        Text("\(gem.beuaxjcaiGetDiamond)")
          .font(.system(size: 12))
          .fontWeight(.black)
          .foregroundColor(.white)
          .padding(.bottom, 7)
        Text(String(format: "%.2f", gem.beuaxjcaiPrice))
          .font(.system(size: 12))
          .fontWeight(.semibold)
          .foregroundColor(.black)
          .frame(width: 76, height: 24, alignment: .center)
          .background(
            RoundedRectangle(cornerRadius: 99).fill(
              VawinvTheme.FaioColor.gradientOrangeToYellow)
          )
      }.frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 20).fill(
            Color(red: 39 / 255, green: 39 / 255, blue: 39 / 255)))
    }

  }
}
