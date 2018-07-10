//
//  ViewController.swift
//  Test
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipLabel: UILabel!
    
    let emojis = ["🥨", "🌮", "🍕", "🍔"]
    
    var flipCount = 0 {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var cards: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cards.index(of: sender) {
            flipCard(withEmoji: emojis[cardNumber], on: sender)
        } else {
            print("Unknown card encountered!")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.2931769192, green: 0.2937060595, blue: 1, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

}

