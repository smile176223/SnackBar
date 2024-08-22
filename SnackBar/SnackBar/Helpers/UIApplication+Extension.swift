//
//  UIApplication+Extension.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import SwiftUI

extension UIApplication {
    public static var screenSize: CGSize {
        Self
            .shared
            .connectedScenes
            .compactMap { scene -> UIWindow? in
                (scene as? UIWindowScene)?.keyWindow
            }
            .first?
            .frame
            .size ?? .zero
    }
}
