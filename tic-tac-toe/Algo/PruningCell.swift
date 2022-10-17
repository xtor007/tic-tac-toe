//
//  PruningCell.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 17.10.2022.
//

import Foundation

class PruningCell: NegaMaxCell {
    
    func go(prevValue: Double) {
        if position.winner() != nil {
            power = -1
            return
        }
        if depth == 0 {
            power = position.calculatePower(forElement: move)
            return
        }
        if position.countOfEmpty == 0 { //draw
            power = 0
            return
        }
        findChildren()
        findPower(prevValue: prevValue)
    }
    
    func findPower(prevValue: Double) {
        for child in children {
            child.go(prevValue: power)
            if -child.power >= power {
                power = -child.power
                solution = child.change
            }
            if -power < prevValue {
                return
            }
        }
    }
    
}
