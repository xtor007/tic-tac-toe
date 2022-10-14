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
    
}
