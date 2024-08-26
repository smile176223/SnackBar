//
//  CGPoint+Extension.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI

extension CGPoint {
    static var outOfScreenPoint: CGPoint {
        CGPoint(x: UIApplication.screenSize.width, y: UIApplication.screenSize.height)
    }
}
