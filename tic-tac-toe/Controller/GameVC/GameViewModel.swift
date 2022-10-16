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
    
    let algoManager: AlgoManager
    var position = Position()
    var isAlgoWork = false
    
    init(algo: Algo) {
        self.algoManager = AlgoManager(algo: algo)
    }
    
    func isMovePossible(coordinates: Coordinates) -> Bool {
        return !isAlgoWork && position.makeMove(element: .cross, coordinates: coordinates)
    }
    
    func getMove(onSucces: @escaping (Coordinates)->(Void)) {
        isAlgoWork = true
        DispatchQueue.global(qos: .background).async {
            let coordinates = self.algoManager.getMove(position: self.position)
            let _ = self.position.makeMove(element: .nought, coordinates: coordinates)
            self.isAlgoWork = false
            DispatchQueue.main.async {
                onSucces(coordinates)
            }
        }
    }
    
}
