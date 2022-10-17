//
//  NegaScoutCell.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 17.10.2022.
//

import Foundation

class NegaScoutCell: PruningCell {
    
    func negaScoutGo(prevValue: Double) {
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
        let prevPower = power
        negaScoutFindPower(prevValue: prevValue+0.5)
        if prevPower == power {
            negaScoutFindPower(prevValue: prevValue)
        }
    }
    
    func negaScoutFindPower(prevValue: Double) {
        for child in children {
            child.negaScoutGo(prevValue: power)
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
