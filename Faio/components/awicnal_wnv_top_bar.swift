//
//  SwiftUIView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct AwicnalWnvTopBar<Actions: View>: View {

    @Environment(\.dismiss) var dismiss

    let awicanlCenterTitle: String?
    @ViewBuilder let awicanlActions: () -> Actions

    init(
        awicanlCenterTitle: String? = nil,
        @ViewBuilder awicanlActions: @escaping () -> Actions = { Spacer() }
    ) {
        self.awicanlCenterTitle = awicanlCenterTitle
        self.awicanlActions = awicanlActions
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // 中间标题
            if let title = awicanlCenterTitle {
                Text(title)
                    .font(.system(size: 24))
                    .fontWeight(.black)
                    .foregroundColor(.white)
            }

            HStack() {
                // 左侧返回
                Button {
                    dismiss()
                } label: {
                    Image("vnzwa_icon_back")
                        .resizable()
                        .frame(width: 40, height: 40)
                }.buttonStyle(.plain)

                // 右侧自定义 actions
                awicanlActions()
            }.frame(height: 40, alignment: .leading)
            
        }.frame(height: 40)
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}

#Preview {
    AwicnalWnvTopBar()
}
