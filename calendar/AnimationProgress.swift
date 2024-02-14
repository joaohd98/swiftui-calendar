//
//  AnimationProgress.swift
//  calendar
//
//  Created by João Damazio on 08/02/24.
//

import Foundation
import SwiftUI

public func animationFromTo(_ progress: CGFloat, fromValue: CGFloat = 0, toValue: CGFloat = 0, range: (CGFloat, CGFloat) = (0, 1), bounce: CGFloat = 0) -> CGFloat {
    let minValue = min(range.0, range.1)
    let maxValue = max(range.0, range.1)

    let valueRange = Double(toValue - fromValue)

    let clampedProgress = fmax(minValue, fmin(maxValue, progress))
    let normalizedProgress = fma((clampedProgress - minValue), 1.0 / (maxValue - minValue), 0.0)

    if bounce > 0 {
       let bounceValue = sin(normalizedProgress * CGFloat.pi) * bounce
       return fromValue + CGFloat(valueRange * normalizedProgress) + bounceValue
   }

   return fromValue + CGFloat(valueRange * normalizedProgress)
}
