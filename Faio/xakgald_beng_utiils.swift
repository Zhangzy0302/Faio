//
//  File.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

enum LocalImageManager {
    static func saveImage(_ image: UIImage) -> String? {
        let fileName = UUID().uuidString + ".jpg"
        let data = image.jpegData(compressionQuality: 0.9)
        
        guard let data else { return nil }
        
        let documentsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path   // ✅ 返回 String，正好给 ieujanMyAvatar 用
        } catch {
            print("Save image error:", error)
            return nil
        }
    }
}

extension Date {
    func toString(_ format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content
  ) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }

  func readBottomSafeArea(_ onChange: @escaping (CGFloat) -> Void) -> some View {
    background(
      GeometryReader { geo in
        Color.clear
          .onAppear {
            onChange(geo.safeAreaInsets.bottom)
          }
      }
    )
  }
}

func delay(_ seconds: Double) async {
  try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
}

struct CustomDialog<Content: View>: View {

  @Binding var isPresented: Bool
  let content: Content

  init(
    isPresented: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self._isPresented = isPresented
    self.content = content()
  }

  var body: some View {
    if isPresented {
      ZStack {
        // 背景遮罩
        Color.black.opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            isPresented = false
          }

        // 弹框内容
        content
          .transition(.scale.combined(with: .opacity))
          .animation(.easeOut(duration: 0.25), value: isPresented)
      }

    }
  }
}

struct BottomSheet<Content: View>: View {

  @Binding var isPresented: Bool
  let content: Content

  init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
    self._isPresented = isPresented
    self.content = content()
  }

  var body: some View {
    if isPresented {
      ZStack {
        Color.black.opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            isPresented = false
          }

        VStack {
          Spacer()

          content
        }.animation(.easeOut(duration: 0.25), value: isPresented)
      }

    }
  }
}
