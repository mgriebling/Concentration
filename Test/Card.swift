//
//  Card.swift
//  Concentration
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    var identifier : Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
}
