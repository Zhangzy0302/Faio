//
//  Untitled.swift
//  Faio
//
//  Created by yangyang on 2026/1/20.
//
import SwiftUI

enum FaioFontWeight {
    case extraLight
    case light
    case regular
    case medium
    case bold
    case heavy
}

enum VawinvTheme {
    enum FaioColor {
        static let yellow = SwiftUI.Color(red: 1, green: 187/255, blue: 0);
        static let orange = SwiftUI.Color(red: 1, green: 110/255, blue: 0);
        static let gradientOrangeToYellow = LinearGradient(colors: [orange, yellow], startPoint: .top, endPoint: .bottom)
        static let backgroundBlack = SwiftUI.Color(red: 29/255, green: 29/255, blue: 29/255)
    }
    
    enum Font {

            private static func name(_ weight: FaioFontWeight) -> String {
                switch weight {
                case .extraLight: return "SourceHanSansSC-ExtraLight"
                case .light:      return "SourceHanSansSC-Light"
                case .regular:    return "SourceHanSansSC-Regular"
                case .medium:     return "SourceHanSansSC-Medium"
                case .bold:       return "SourceHanSansSC-Bold"
                case .heavy:      return "SourceHanSansSC-Heavy"
                }
            }

            static func faio(
                _ size: CGFloat,
                weight: FaioFontWeight = .regular
            ) -> SwiftUI.Font {
                .custom(name(weight), size: size)
            }
        }
}
