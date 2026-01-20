//
//  SwiftUIView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct AwicnalWnvTopBar: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // 左侧返回按钮
            Button(action: {
                dismiss()
            }) {
                Image("vnzwa_icon_back")
                    .resizable()
                    .frame(width: 40, height: 40)
            }

            
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
        
    }
}

