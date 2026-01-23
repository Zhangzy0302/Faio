//
//  feqocn_button.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//

import SwiftUI

struct FeqocnButton: View {
    let feqocnText: String
    var feqocnWidth: CGFloat = .infinity
    var feqocnHeight: CGFloat = 53
    var feqocnBgColorIsOrange: Bool = true
    var feqocnBgColor: Color = .white
    var feqocnFontSize: CGFloat = 16
    var feqocnFontWeight: Font.Weight = .black
    var feqocnFontColor: Color = .black
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(feqocnText)
                .font(.system(size: feqocnFontSize, weight: feqocnFontWeight))
                .foregroundColor(feqocnFontColor)
                    .padding()
                     .frame(maxWidth: feqocnWidth, maxHeight: feqocnHeight)
                     .background(ZStack {
                         if feqocnBgColorIsOrange {
                             LinearGradient(
                                 colors: [Color.nzcawdMainOrange, Color.nzcawdMainYellow],
                                 startPoint: .top,
                                 endPoint: .bottom
                             )
                         } else {
                             feqocnBgColor
                         }
                     })
                     .cornerRadius(30).padding(0)
        }.buttonStyle(.plain)
    }
}
