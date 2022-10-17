//
//  AlgoManager.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 15.10.2022.
//

import Foundation

class AlgoManager {
    
    private let algo: Algo
    
    private let depth = 2
    
    private(set) var duration = AlgoWorkDuration()
    
    init(algo: Algo) {
        self.algo = algo
    }
    
    func getMove(position: Position) -> Coordinates {
        var solution = Coordinates(x: 0, y: 0)
        let startTime = CFAbsoluteTimeGetCurrent()
        switch algo {
        case .negaMax:
            let cell = NegaMaxCell(position: position, change: Coordinates(x: 0, y: 0), depth: depth, move: .nought)
            cell.go()
            solution = cell.solution
        case .pruning:
            let cell = PruningCell(position: position, change: Coordinates(x: 0, y: 0), depth: depth, move: .nought)
            cell.go(prevValue: -1)
            solution = cell.solution
        case .negaScout:
            let cell = NegaScoutCell(position: position, change: Coordinates(x: 0, y: 0), depth: depth, move: .nought)
            cell.negaScoutGo(prevValue: -1)
            solution = cell.solution
        }
        let finishTime = CFAbsoluteTimeGetCurrent()
        duration.durations.append(finishTime - startTime)
        return solution
    }
    
}
