//
//  Color+Extension.swift
//  SnackBarExample
//
//  Created by Liam on 2024/8/28.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Color {
    static var lightBlue: Color { Color(hex: "d8eaf5") }
    static var lightGreen: Color { Color(hex: "e1f8e2") }
    static var lightYellow: Color { Color(hex: "f8f0e1") }
    static var lightPurple: Color { Color(hex: "efe9fb") }
    
    static var darkBlue: Color { Color(hex: "3b80bc") }
    static var darkGreen: Color { Color(hex: "4ea637") }
    static var darkYellow: Color { Color(hex: "d28431") }
    static var darkPurple: Color { Color(hex: "b996ff") }
}
