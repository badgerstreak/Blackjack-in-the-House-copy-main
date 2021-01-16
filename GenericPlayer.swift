//
//  GenericPlayer.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation

class GenericPlayer {
    var hand:Hand

    init(hand: Hand) {
        self.hand = hand

    }
}



// MARK: - GenericPlayer
/// Added by Rob Dixon, 2020-11-10
/// Convenience Properties
/// We can add some convenience properties to GenericPlayer...
/// ...which allow us to make the code more readable
/// e.g. instead of
/// if dealer.hand.getLength() == 2
/// if player1.hand.getValue() == 21
/// we can say
/// if dealer.numCards == 2
/// if player1.isBlackJack
/// So we can think more in terms of the card game, rather than artificial programming constructs
extension GenericPlayer {
    
    var numCards: Int {
        hand.getLength()
    }
    
    var points: Int {
        hand.getValue()
    }
    
    var isBlackjack: Bool {
        hand.getValue() == 21
    }
    
    var isBust: Bool {
        hand.getValue() > 21
    }
}
