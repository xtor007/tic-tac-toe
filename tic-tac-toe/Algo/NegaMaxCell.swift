//
//  NegaMax.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 15.10.2022.
//

import Foundation

class NegaMaxCell {
    
    var position: Position
    let change: Coordinates
    let depth: Int
    let move: Element
    
    var children = [NegaMaxCell]()
    var power = -1.0
    var solution: Coordinates!
    
    init(position: Position, change: Coordinates, depth: Int, move: Element) {
        self.position = position
        self.change = change
        self.depth = depth
        self.move = move
    }
    
    func go() {
        if position.winner() != nil {
            power = -1
            return
        }
        if depth == 0 {
            power = position.calculatePower(forElement: move)
            return
        }
        findChildren()
        findPower()
    }
    
    private func findPower() {
        for child in children {
            child.go()
            if -child.power >= power {
                power = -child.power
                solution = child.change
            }
        }
    }
    
    private func findChildren() {
        for y in 0..<10 {
            for x in 0..<10 {
                if position.mtx[y][x] == nil {
                    children.append(NegaMaxCell(
                        position: Position(addValueTo: Coordinates(x: x, y: y), element: move, from: position),
                        change: Coordinates(x: x, y: y),
                        depth: depth-1,
                        move: move.toogle()
                    ))
                }
            }
        }
    }
    
}
