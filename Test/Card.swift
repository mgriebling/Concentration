//
//  Card.swift
//  Concentration
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import Foundation

public struct Card : Hashable {
    
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    private var identifier : Int
    
    static private var identifierFactory = 0
    
    static private func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
}
