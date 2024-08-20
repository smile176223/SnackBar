//
//  DispatchQueue+Extension.swift
//  SnackBar
//
//  Created by Liam on 2024/8/20.
//

import Foundation

public protocol Scheduler {
    func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) -> DispatchWorkItem
}

extension DispatchQueue: Scheduler {
    public func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) -> DispatchWorkItem {
        let workItem = DispatchWorkItem(block: execute)
        self.asyncAfter(deadline: deadline, execute: workItem)
        return workItem
    }
}
