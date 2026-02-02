//
//  bawnbv_text_field.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//
import SwiftUI

struct BawnbvTextField: View {

  let placeholder: String
  @Binding var text: String

  @FocusState.Binding var isFocused: Bool

  var keyboardType: UIKeyboardType = .default
  var height: CGFloat = 52
  var verticalPadding: CGFloat = 16
  var cornerRadius: CGFloat = 20
  var keyboardSendAction: SubmitLabel = .return

  var body: some View {
    TextField("", text: $text)
      .placeholder(when: text.isEmpty) {
        Text(placeholder)
          .font(.system(size: 14))
          .fontWeight(.regular)
          .foregroundColor(
            Color(red: 129 / 255, green: 129 / 255, blue: 130 / 255)
          )
      }
      .submitLabel(keyboardSendAction)
      .textInputAutocapitalization(.never)
      .focused($isFocused)
      .font(.system(size: 16))  // 输入文字字体
      .tint(.black)
      .keyboardType(keyboardType)
      .padding(.horizontal, 16)
      .padding(.vertical, verticalPadding)
      .frame(height: height, alignment: .topLeading)
      .background(
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(.white)
      )
  }
}
