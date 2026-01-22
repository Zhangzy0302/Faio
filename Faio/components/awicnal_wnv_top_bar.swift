//
//  SwiftUIView.swift
//  Faio
//
//  Created by yangyang on 2026/1/19.
//

import SwiftUI

struct AwicnalWnvTopBar: View {

    @Environment(\.dismiss) var dismiss
    
    var awicanlCenterTitle: String? = nil

    var body: some View {
        ZStack(){
            if let title = awicanlCenterTitle { // 更优雅的可选值解包方式
                            Text(title)
                                .font(.system(size: 24))
                                .fontWeight(.black)
                                .foregroundColor(.white)
                        }
            HStack(alignment: .top, spacing: 16) {
                // 左侧返回按钮
                Button(action: {
                    dismiss()
                }) {
                    Image("vnzwa_icon_back")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
        .padding(.horizontal, 20)
        .padding(.top, 16)
        
        
    }
}

