//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var score = 0
    var flips = 0
    
    var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = newValue == index
            }
        }
    }
    
    func chooseCard(at index: Int) {
        flips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].wasSeen {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].wasSeen = cards[index].isFaceUp
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        var shuffledCards = [Card]()
        for _ in cards {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        cards = shuffledCards
    }
    
}
