//
//  Hand.swift
//  Blackjackk
//
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//
import Foundation

class Hand {
   private var hand = [Card]()

    func addCard(card: Card){
        hand.append(card)
        
    }
    
    func reset(){
        hand.removeAll()
    }
    
    func getValue()->Int{
        var handValue = 0;
        var hasAceInHand=false;
        
        for card in hand {
            var cardsValue =  card.getValue()
            if (cardsValue > 10){
                cardsValue = 10;
            }
            
            handValue += cardsValue
            
            if (cardsValue == 1){
                hasAceInHand = true
            }
        }
        if (hasAceInHand && handValue <= 11){
            handValue += 10
        }
        
        return handValue;

    }
    
    func getLength()-> Int{
        return hand.count
    }
 
}
