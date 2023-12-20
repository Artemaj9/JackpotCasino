//
//  Color+Ext.swift
//


import SwiftUI

extension Color {
    
    static func white(_ white: Double, opacity: Double = 1, _ colorSpace: Color.RGBColorSpace = .sRGB) -> Color {
        Color(colorSpace, white: white, opacity: opacity)
    }
}
