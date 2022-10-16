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
    
    init(algo: Algo) {
        self.algo = algo
    }
    
    func getMove(position: Position) -> Coordinates {
        switch algo {
        case .negaMax:
            let cell = NegaMaxCell(position: position, change: Coordinates(x: 0, y: 0), depth: depth, move: .nought)
            cell.go()
            return cell.solution
        case .pruning:
            print(1)
            return Coordinates(x: 0, y: 0)
        case .negaScout:
            print(2)
            return Coordinates(x: 0, y: 0)
        }
    }
    
}
