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
    
    private(set) var countOfEmpty: Int
    
    init() {
        mtx = Array(repeating: Array(repeating: nil, count: 10), count: 10)
        countOfEmpty = 100
    }
    
    init(addValueTo coordinates: Coordinates, element: Element, from: Position) {
        mtx = from.mtx
        mtx[coordinates.y][coordinates.x] = element
        countOfEmpty = from.countOfEmpty - 1
    }
    
    mutating func makeMove(element: Element, coordinates: Coordinates) -> Bool {
        if mtx[coordinates.y][coordinates.x] == nil {
            mtx[coordinates.y][coordinates.x] = element
            countOfEmpty -= 1
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
    
    func calculatePower(forElement element: Element) -> Double {
        var myScore = 0.0
        var enemyScore = 0.0
        for y in 0..<10 {
            for x in 0..<10 {
                if mtx[y][x] == nil {
                    for direction in Direction.allDirections {
                        let coordinates = Coordinates(x: x, y: y).afterMove(direction)
                        if coordinates.isRight() {
                            if let currentElement = mtx[coordinates.y][coordinates.x] {
                                let depth = getDepth(
                                    coordinates: coordinates,
                                    direction: direction,
                                    element: currentElement,
                                    prevDepth: 0
                                )
                                var score = 0.0
                                switch depth {
                                case 1:
                                    score = 0.05
                                case 2:
                                    score = 0.15
                                case 3:
                                    score = 0.3
                                case 4:
                                    score = 1
                                default:
                                    score = 0
                                }
                                if currentElement == element {
                                    myScore += score
                                } else {
                                    enemyScore += score
                                }
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
        return 1 - 2*(enemyScore/(myScore+enemyScore))
    }
    
    private func getDepth(coordinates: Coordinates, direction: Direction, element: Element, prevDepth: Double) -> Double {
        if !coordinates.isRight() || mtx[coordinates.y][coordinates.x] != element {
            return prevDepth
        }
        return getDepth(coordinates: coordinates.afterMove(direction), direction: direction, element: element, prevDepth: prevDepth+1)
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
