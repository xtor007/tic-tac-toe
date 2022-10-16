//
//  Position.swift
//  tic-tac-toe
//
//  Created by Anatoliy Khramchenko on 14.10.2022.
//

import Foundation

enum Element {
    
    case cross, nought
    
    func toogle() -> Element {
        switch self {
        case .cross:
            return .nought
        case .nought:
            return .cross
        }
    }
    
}

enum Direction {
    
    case up
    case upleft, upright
    case left, right
    case downleft, downright
    case down
    
    static let allDirections = [Direction.upright, .upleft, .up, .right, .left, .downright, .downleft, .down]
    
    static let halfDirection = [Direction.down, .downright, .right, .downleft]
    
    func getOpposite() -> Direction {
        switch self {
        case .up:
            return .down
        case .upleft:
            return .downright
        case .upright:
            return .downleft
        case .left:
            return .right
        case .right:
            return .left
        case .downleft:
            return .upright
        case .downright:
            return .upleft
        case .down:
            return .up
        }
    }
    
}

struct Position {
    
    private(set) var mtx: [[Element?]]
    
    private var isHere = Array(repeating: Array(repeating: false, count: 10), count: 10)
    
    init() {
        mtx = Array(repeating: Array(repeating: nil, count: 10), count: 10)
    }
    
    init(addValueTo coordinates: Coordinates, element: Element, from: Position) {
        mtx = from.mtx
        mtx[coordinates.y][coordinates.x] = element
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
    
    mutating func calculatePower(forElement element: Element) -> Double {
        var myScore = 0.0
        var enemyScore = 0.0
        isHere = Array(repeating: Array(repeating: false, count: 10), count: 10)
        for y in 0..<10 {
            for x in 0..<10 {
                if let currentElement = mtx[y][x] {
                    isHere[y][x] = true
                    for direction in Direction.halfDirection {
                        var depth = getDepth(coordinates: Coordinates(x: x, y: y), direction: direction, element: currentElement, prevDepth: 1)
                        depth += getDepth(coordinates: Coordinates(x: x, y: y), direction: direction.getOpposite(), element: currentElement, prevDepth: 1)
                        if depth > 2 {
                            if currentElement == element {
                                myScore += depth-1
                            } else {
                                enemyScore += depth-1
                            }
                        }
                    }
                }
            }
        }
        if myScore == 0 && enemyScore == 0 {
            return 0
        }
        if myScore == 0 {
            return -0.99
        }
        if enemyScore == 0 {
            return 0.99
        }
        enemyScore *= 2
        return (myScore/(myScore+enemyScore)) - (enemyScore/(myScore+enemyScore))
    }
    
    private mutating func getDepth(coordinates: Coordinates, direction: Direction, element: Element, prevDepth: Double) -> Double {
        if !coordinates.isRight() || mtx[coordinates.y][coordinates.x] == element.toogle() {
            return prevDepth
        }
        isHere[coordinates.y][coordinates.x] = true
        if mtx[coordinates.y][coordinates.x] == nil {
            return getDepth(coordinates: coordinates.afterMove(direction), direction: direction, element: element, prevDepth: prevDepth+0.23)
        } else {
            return getDepth(coordinates: coordinates.afterMove(direction), direction: direction, element: element, prevDepth: prevDepth+1)
        }
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
