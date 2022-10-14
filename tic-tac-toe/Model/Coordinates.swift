//
//  Coordinates.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import Foundation

struct Coordinates: Equatable, Hashable {
    
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(tag: Int) {
        x = tag % 10
        y = tag / 10
    }
    
    func isRight() -> Bool {
        return x>=0 && x<10 && y>=0 && y<10
    }
    
    func afterMove(_ move: Direction) -> Coordinates {
        switch move {
        case .up:
            return Coordinates(x: x, y: y-1)
        case .upleft:
            return Coordinates(x: x-1, y: y-1)
        case .upright:
            return Coordinates(x: x+1, y: y-1)
        case .left:
            return Coordinates(x: x-1, y: y)
        case .right:
            return Coordinates(x: x+1, y: y)
        case .downleft:
            return Coordinates(x: x-1, y: y+1)
        case .downright:
            return Coordinates(x: x+1, y: y+1)
        case .down:
            return Coordinates(x: x, y: y+1)
        }
    }
    
}
