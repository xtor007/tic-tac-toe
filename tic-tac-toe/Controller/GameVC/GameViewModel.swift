//
//  GameViewModel.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import Foundation

enum Algo: Int {
    
    case negaMax = 0
    case pruning = 1
    case negaScout = 2
    
}

class GameViewModel {
    
    let algo: Algo
    var position = Position()
    var isAlgoWork = false
    
    init(algo: Algo) {
        self.algo = algo
    }
    
    func isMovePossible(coordinates: Coordinates) -> Bool {
        return !isAlgoWork && position.makeMove(element: .cross, coordinates: coordinates)
    }
    
    func getMove() -> Coordinates {
        isAlgoWork = true
        return Coordinates(x: 6, y: 7)
    }
    
}
