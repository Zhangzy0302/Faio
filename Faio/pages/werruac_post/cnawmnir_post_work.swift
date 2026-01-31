import PhotosUI
import SwiftUI

struct CnawmnirPostWork: View {
  @Binding var appPath: NavigationPath
  @State private var cnawmnirCopywriter: String = ""
  @State private var cnawnirUploadImageList: [String] = []
  @State private var selectedAvatarItems: [PhotosPickerItem] = []  // 多选
  @State private var showAvatarPicker: Bool = false

  @FocusState private var cnawmnirNameFocus: Bool

  @EnvironmentObject var workVM: FaioWorksViewModel
  var body: some View {
    ZStack(alignment: .top) {
      VawinvTheme.FaioColor.backgroundBlack.ignoresSafeArea()
      VStack {
        AwicnalWnvTopBar(awicanlCenterTitle: "Edit")
        ScrollView {
          VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 12) {
              Text("Copywriter")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
              BawnbvTextField(
                placeholder: "Please enter", text: $cnawmnirCopywriter,
                isFocused: $cnawmnirNameFocus)
            }.padding(.bottom, 20)
            VStack(alignment: .leading, spacing: 12) {
              Text("Upload")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
              eunksdImageShow(
                cnawnirUploadImageList: $cnawnirUploadImageList, showAvatarPicker: $showAvatarPicker
              )
            }

          }.padding(.top, 20)

        }.padding(.horizontal, 20)
        FeqocnButton(
          feqocnText: "Post",
          feqocnHeight: 52,
          action: {
            if cnawmnirCopywriter.isEmpty {
              FaioHUD.error("Please enter copywriter")
              return
            }
            if cnawnirUploadImageList.isEmpty {
              FaioHUD.error("Please upload image")
              return
            }
            let cnwainNewWorkId: Int = workVM.addNewWork(
              textContent: cnawmnirCopywriter, imageListUrl: cnawnirUploadImageList)
            appPath.removeLast()

            appPath.append(
              AppRoute.workDetail(workId: cnwainNewWorkId)
            )
            FaioHUD.success("Post success")

          }
        ).padding(.bottom, 20).padding(.top, 60)
      }
    }.photosPicker(
      isPresented: $showAvatarPicker,
      selection: $selectedAvatarItems,
      maxSelectionCount: 3 - cnawnirUploadImageList.count,  // 最大选择数
      matching: .images
    )
    .onChange(of: selectedAvatarItems) { items in
      Task {
        var newPaths: [String] = []

        for item: PhotosPickerItem in items {
          if let data = try? await item.loadTransferable(type: Data.self),
            let image = UIImage(data: data),
            let localPath = LocalImageManager.saveImage(image)
          {
            newPaths.append(localPath)
          }
        }

        let remainCount = max(0, 3 - cnawnirUploadImageList.count)
        let finalPaths = Array(newPaths.prefix(remainCount))

        cnawnirUploadImageList.append(contentsOf: finalPaths)
        selectedAvatarItems.removeAll()
      }
    }.navigationBarHidden(true).onTapGesture {
      cnawmnirNameFocus = false
    }
  }

  private struct eunksdImageShow: View {
    @Binding var cnawnirUploadImageList: [String]
    @Binding var showAvatarPicker: Bool

    var body: some View {
      ScrollView(.horizontal) {
        HStack(spacing: 15) {
          ZStack {
            Circle()
              .fill(Color(red: 204 / 255, green: 204 / 255, blue: 204 / 255))
              .frame(width: 56)
              .overlay(content: {
                Image("vnzwa_icon_add").resizable().frame(width: 20, height: 20)
              })
          }.frame(width: 148, height: 200)
            .background(
              RoundedRectangle(cornerRadius: 20)
                .fill(.white)
            ).onTapGesture {
              showAvatarPicker = true
            }
          ForEach(cnawnirUploadImageList, id: \.self) { image in
              ZStack(alignment: .topTrailing) {
              ZwnagIreujImage(
                zwnagIreujImageUrl: image, zwnagIreujWidth: 148, zwnagIreujHeight: 200
              )
              .cornerRadius(20)
              Circle()
                .fill(.black)
                .frame(width: 24, height: 24)
                .overlay {
                  Image("vnzwa_icon_close")
                    .resizable()
                    .frame(width: 12, height: 12)
                }
                .padding(4)
                .onTapGesture {
                  cnawnirUploadImageList.removeAll { $0 == image }
                }
            }.frame(width: 148, height: 200)
              .background(
                RoundedRectangle(cornerRadius: 20)
                  .fill(.white)
              )
          }
        }
      }
    }
  }
}
