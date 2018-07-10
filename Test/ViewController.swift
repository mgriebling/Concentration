//
//  ViewController.swift
//  Test
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cards.count+1)/2)

    @IBOutlet weak var flipLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var cards: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cards.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Unknown card encountered!")
        }
    }
    
    func updateViewFromModel() {
        for index in cards.indices {
            let button = cards[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.2931769192, green: 0.2937060595, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojis = ["🥨", "🌮", "🍕", "🍔", "🍟", "🥟", "🍩", "🍦", "🍰"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emoji[card.identifier] = emojis.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

