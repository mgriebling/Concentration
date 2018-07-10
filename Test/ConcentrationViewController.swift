//
//  ViewController.swift
//  Test
//
//  Created by Michael Griebling on 2018-07-10.
//  Copyright © 2018 Solinst Canada. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cards.count+1)/2)
    
    let themes = [
        Theme(symbols:["🥨", "🌮", "🍕", "🍔", "🍟", "🥟", "🍩", "🍦", "🍰", "🍭"], background: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cardBackground: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)),  // food theme
        Theme(symbols:["🇩🇪", "🇺🇸", "🇨🇦", "🏳️‍🌈", "🇧🇪", "🇬🇧", "🇫🇷", "🇮🇹", "🇱🇹", "🇲🇽"], background: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1), cardBackground: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)),  // flag theme
        Theme(symbols:["🐵", "🦁", "🐷", "🐹", "🐶", "🐱", "🐭", "🦊", "🐰", "🐯"], background: #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), cardBackground: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)),  // animals theme
        Theme(symbols:["⛷", "🏋️‍♂️", "🤼‍♂️", "🤸‍♀️", "🏌️‍♀️", "🏇", "🏊‍♀️", "🚴‍♀️", "🏄🏾‍♀️", "🤺"], background: #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1), cardBackground: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)),  // sports theme
        Theme(symbols:["🧐", "😃", "😇", "😎", "🤩", "😫", "🤬", "☹️", "😭", "🤯"], background: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), cardBackground: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)),  // faces theme
        Theme(symbols:["💤", "♻️", "🔆", "🎵", "🔵", "🔔", "♥️", "💲", "🚭", "❌"], background: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cardBackground: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))   // symbols theme
    ]
    var activeTheme = 0 {
        didSet {
            backgroundView.backgroundColor = themes[activeTheme].background
            updateViewFromModel()
        }
    }
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet var cards: [UIButton]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newGame(UIButton())
    }
    
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : themes[activeTheme].cardBackground
            }
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        activeTheme = Int(arc4random_uniform(UInt32(themes.count)))
        game = Concentration(numberOfPairsOfCards: (cards.count+1)/2)
        flipCount = 0
        emojis = themes[activeTheme].symbols
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    lazy var emojis = themes[activeTheme].symbols
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emoji[card.identifier] = emojis.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

