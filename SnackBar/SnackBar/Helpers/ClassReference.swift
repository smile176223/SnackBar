//
//  ClassReference.swift
//  SnackBar
//
//  Created by Liam on 2024/8/22.
//

import Foundation

final class ClassReference<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}
