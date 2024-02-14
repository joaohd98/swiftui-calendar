//
//  MapRange.swift
//  calendar
//
//  Created by João Damazio on 08/02/24.
//

import SwiftUI

public func mapRange(inMin: Double, inMax: Double, outMin: Double, outMax: Double, valueToMap: Double) -> Double {
    if inMin == inMax {
        return outMax
    }

    let clampedValue = min(max(valueToMap, inMin), inMax)
    let mappedValue = fma((clampedValue - inMin) / (inMax - inMin), (outMax - outMin), outMin)

    return mappedValue
}
