//
//  SnackBarParameters.swift
//  SnackBar
//
//  Created by Liam on 2024/8/23.
//

import SwiftUI

public struct SnackBarParameters {
    
    public enum Position {
        case top
        case bottom
    }
    
    /// Control SnackBar slide position
    public var position: Position = .bottom
    /// Display position include padding
    public var padding: CGFloat = 10
    /// Control SnackBar animation type
    public var animation: Animation = .spring()
}

// MARK: - Update Method
extension SnackBarParameters {
    public func position(_ position: Position) -> Self {
        updateParameters { $0.position = position }
    }
    
    public func padding(_ padding: CGFloat) -> Self {
        updateParameters { $0.padding = padding }
    }
    
    public func animation(_ animation: Animation) -> Self {
        updateParameters { $0.animation = animation }
    }
    
    private func updateParameters(_ update: (inout Self) -> Void) -> Self {
        var parameters = self
        update(&parameters)
        return parameters
    }
}
