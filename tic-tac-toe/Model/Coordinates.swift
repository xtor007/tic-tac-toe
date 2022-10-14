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
    
}
