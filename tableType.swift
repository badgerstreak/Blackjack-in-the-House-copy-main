//
//  tableType.swift
//  Blackjack in the House
//
//  Created by Joe Curran on 07/10/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation
import UIKit


 
enum TableType: String {
    case ovaloffice = "ovaloffice"
    case austin = "austin"
    case bond = "bond"
    case moesbar = "moes bar"
    case deadpool = "deadpool"
    case casino = "casino"
}
extension TableType {
    static func `for`(playerScore: Int) -> TableType {
        switch playerScore {
        
        
        case 0...2:
            return .moesbar
        case 3...19:
            return .ovaloffice
        case 20...29:
            return .deadpool
        case 30...39:
            return .austin
        case 40...49:
            return .moesbar
        case 50...59:
            return .bond
        case 60...69:
            return .casino
        case 70...79:
            return .ovaloffice
        case 80...89:
            return .austin
        case 90...99:
            return .deadpool
        case 100...109:
            return .bond
        case 110...119:
            return .moesbar
        case 120...129:
            return .casino
        case 130...139:
            return .ovaloffice
        case 140...149:
            return .bond
        case 150...159:
            return .casino
        case 160...169:
            return .deadpool
        case 170...179:
            return .austin
        case 180...189:
            return .moesbar
        case 190...199:
            return .deadpool
        case 200...209:
            return .casino
        case 210...219:
            return .bond
        case 220...229:
            return .ovaloffice
        case 230...239:
            return .austin
        case 240...249:
            return .moesbar
        case 250...259:
            return .deadpool
        case 260...269:
            return .bond
        case 270...279:
            return .casino
        case 280...289:
            return .ovaloffice
        case 290...299:
            return .austin
            
        
        default:
            return .moesbar
        }
    }
    var imageName: String {rawValue}
  }




