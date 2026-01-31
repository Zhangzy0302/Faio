import SwiftUI

struct ZwnagIreujImage: View {

  let zwnagIreujImageUrl: String
  let zwnagIreujWidth: CGFloat?
  let zwnagIreujHeight: CGFloat?
  let zwnagIreujIsCircle: Bool
  let zwnagIreujContentMode: ContentMode

  init(
    zwnagIreujImageUrl: String,
    zwnagIreujWidth: CGFloat? = nil,
    zwnagIreujHeight: CGFloat? = nil,
    zwnagIreujIsCircle: Bool = false,
    zwnagIreujContentMode: ContentMode = .fill
  ) {
    self.zwnagIreujImageUrl = zwnagIreujImageUrl
    self.zwnagIreujWidth = zwnagIreujWidth
    self.zwnagIreujHeight = zwnagIreujHeight
    self.zwnagIreujIsCircle = zwnagIreujIsCircle
    self.zwnagIreujContentMode = zwnagIreujContentMode
  }

  var body: some View {
    let imageView = buildImage()
      .frame(
        width: zwnagIreujWidth,
        height: zwnagIreujHeight
      )
      .clipped()

    if zwnagIreujIsCircle {
      imageView
        .clipShape(Circle())
    } else {
      imageView
    }
  }
}

extension ZwnagIreujImage {

  fileprivate func isLocalFilePath(_ path: String) -> Bool {
    path.hasPrefix("/")
  }

  @ViewBuilder
  fileprivate func buildImage() -> some View {
    if zwnagIreujImageUrl.isEmpty {
      placeholderView()
    }

    // asset
    else if !isLocalFilePath(zwnagIreujImageUrl) {

      Image(zwnagIreujImageUrl)
        .resizable()
        .aspectRatio(contentMode: zwnagIreujContentMode)

    }
    // local file
    else if let uiImage = UIImage(contentsOfFile: zwnagIreujImageUrl) {

      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: zwnagIreujContentMode)

    }
    // 兜底（非常重要）
    else {

    }
  }

  fileprivate func placeholderView() -> some View {
    ZStack {
      Color(.systemGray5)
      Image(systemName: "photo")
        .foregroundColor(.gray)
    }
  }
}
