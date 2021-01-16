//
//  Outcome.swift
//  Blackjack in the House
//
//  
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation

// MARK: - Outcome
/// A game has a single Outcome, from 7 possible Outcomes
/// So we implement it as an enum
///
enum Outcome {
    
    /// These are the possible game outcomes
    case playerBlackjack,
         dealerBlackjack,
         playerBust,
         dealerBust,
         playerWin,
         dealerWin,
         tie
    
    /// playerWon
    /// examine the outcome cases, to determine if the player won
    var playerWon: Bool {
        switch self {
            case .playerBlackjack, .dealerBust, .playerWin:
                return true
            default:
                return false
        }
    }
    
    /// instructionText
    /// Used by the UI, to describe the game outcome
    var instructionText: String {
        switch self {
            case .playerBlackjack:
                return "You Got BlackJack!"
            case .dealerBlackjack:
                return "Dealer got BlackJack!"
            case .playerBust:
                return " Bust!"
            case .dealerBust:
                return "Dealer Busts. You Win!"
            case .playerWin:
                return "You Win!"
            case .dealerWin:
                return "You Lose!"
            case .tie:
                return "Tie - Dealer Wins!"
        }
    }
    
    static func forPlayer(_ player: Player, dealer: Dealer) -> Outcome? {
        /// Return the game outcome, for the given state of player and dealer
        /// If the given game state finishes a game, return the Outcome
        /// else return nil (the game is still in progress)
        /// Note: using simple tests allows us to avoid an if-else pyramid of doom
        ///
        /// 1. Blackjack or bust
        if dealer.isBlackjack {
            return .dealerBlackjack
        }
        if player.isBlackjack {
            return .playerBlackjack
        }
        if player.isBust {
            return .playerBust
        }
        if dealer.isBust {
            return .dealerBust
        }
        /// 2. game is still in progress
        if !player.isYeilding() {
            /// Game is not over
            return nil
        }
        /// 3. game is over... who won?
        let dealerMargin = dealer.points - player.points
        switch dealerMargin {
            case _ where dealerMargin < 0:
                return .playerWin
            case 0:
                return .tie
            default:
                return .dealerWin
        }
    }
}
