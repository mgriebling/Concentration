//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flips = 0
    
    var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = newValue == index
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards!")
        flips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
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
    
    private func removeRandomCard() -> Card {
        return cards.remove(at: cards.count.arc4random)
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        var shuffledCards = [Card]()
        for _ in cards {
            shuffledCards.append(removeRandomCard())
        }
        cards = shuffledCards
    }
    
}

extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}
