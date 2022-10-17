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
            print(1)
            return Coordinates(x: 0, y: 0)
        case .negaScout:
            print(2)
            return Coordinates(x: 0, y: 0)
        }
        let finishTime = CFAbsoluteTimeGetCurrent()
        duration.durations.append(finishTime - startTime)
        return solution
    }
    
}
