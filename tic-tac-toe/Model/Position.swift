//
//  Position.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import Foundation

enum Element {
    case cross, nought
}

enum Direction {
    
    case up
    case upleft, upright
    case left, right
    case downleft, downright
    case down
    
    static let allDirections = [Direction.upright, .upleft, .up, .right, .left, .downright, .downleft, .down]
    
}

struct Position {
    
    private(set) var mtx: [[Element?]]
    
    init() {
        mtx = Array(repeating: Array(repeating: nil, count: 10), count: 10)
    }
    
    mutating func makeMove(element: Element, coordinates: Coordinates) -> Bool {
        if mtx[coordinates.y][coordinates.x] == nil {
            mtx[coordinates.y][coordinates.x] = element
            return true
        } else {
            return false
        }
    }
    
    func winner() -> Element? {
        for y in 0..<10 {
            for x in 0..<10 {
                if mtx[y][x] != nil {
                    for direction in Direction.allDirections {
                        let coordinates = Coordinates(x: x, y: y)
                        if mtx[y][x] != nil && isWinIn(coordinates: coordinates.afterMove(direction), direction: direction, element: mtx[y][x]!, depth: 3) {
                            return mtx[y][x]
                        }
                    }
                }
            }
        }
        return nil
    }
    
    private func isWinIn(coordinates: Coordinates, direction: Direction, element: Element, depth: Int) -> Bool {
        if !coordinates.isRight() || mtx[coordinates.y][coordinates.x] != element {
            return false
        }
        if depth == 0 {
            return true
        }
        return isWinIn(coordinates: coordinates.afterMove(direction), direction: direction, element: element, depth: depth-1)
    }
    
}