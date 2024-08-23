//
//  SnackBarParameters.swift
//  SnackBar
//
//  Created by Liam on 2024/8/23.
//

import Foundation

public struct SnackBarParameters {
    
    public enum Position {
        case top
        case bottom
    }
    
    public var position: Position = .bottom
    public var verticalPadding: CGFloat = 10
    
    
    public func position(_ position: Position) -> SnackBarParameters {
        updateParameters { $0.position = position }
    }
    
    public func verticalPadding(_ verticalPadding: CGFloat) -> SnackBarParameters {
        updateParameters { $0.verticalPadding = verticalPadding }
    }
    
    private func updateParameters(_ update: (inout SnackBarParameters) -> Void) -> SnackBarParameters {
        var parameters = self
        update(&parameters)
        return parameters
    }
}
