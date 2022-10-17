//
//  AlgoWorkDuration.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 17.10.2022.
//

import Foundation

struct AlgoWorkDuration {
    
    var durations = [CFAbsoluteTime]()
    
    func getStat() -> (CFAbsoluteTime, CFAbsoluteTime, CFAbsoluteTime) {
        var minValue = durations[0]
        var maxValue = durations[0]
        var averageValue = CFAbsoluteTime(0)
        for duration in durations {
            if minValue > duration {
                minValue = duration
            }
            if maxValue < duration {
                maxValue = duration
            }
            averageValue += duration
        }
        averageValue /= Double(durations.count)
        return (maxValue, minValue, averageValue)
    }
    
}
