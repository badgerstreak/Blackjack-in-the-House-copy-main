//
//  Theme.swift
//  Blackjack in the House
//
//  
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import Foundation

// MARK: - Theme
/// A Theme encapsulates the data and methods which we use to manage the game sounds
/// NOTE: as far as possible, we keep the workings private...
/// ...and only expose properties and methods that other objects **need** to see
///
/// Publicly exposed methods:
/// * theme.randomSoundName(forOutcome:)
/// * Theme.theme(forPlayerScore:)
/// * Theme.checkAllSoundFilesExist()
class Theme {
    
    private let name: String
    
    private let playerBlackjackSoundNames: [String]
    private let dealerBlackjackSoundNames: [String]
    private let playerBustSoundNames: [String]
    private let dealerBustSoundNames: [String]
    private let playerWinSoundNames: [String]
    private let dealerWinSoundNames: [String]
    private let tieSoundNames: [String]
    
    private static let errorSoundName = "silence1" /// Error - Used when a sound can't be found
    private var previousSoundName: String? /// Used to avoid immediately repeating a sound
    
    private init(name: String, playerBlackjackSoundNames: [String], dealerBlackjackSoundNames: [String], playerBustSoundNames: [String], dealerBustSoundNames: [String], playerWinSoundNames: [String], dealerWinSoundNames: [String], tieSoundNames: [String]) {
        self.name = name
        self.playerBlackjackSoundNames = playerBlackjackSoundNames
        self.dealerBlackjackSoundNames = dealerBlackjackSoundNames
        self.playerBustSoundNames = playerBustSoundNames
        self.dealerBustSoundNames = dealerBustSoundNames
        self.playerWinSoundNames = playerWinSoundNames
        self.dealerWinSoundNames = dealerWinSoundNames
        self.tieSoundNames = tieSoundNames
    }
    
    private func soundNameArray(forOutcome outcome: Outcome) -> [String] {
        /// For the given outcome, return the array of possible soundNames
        switch outcome {
            case .playerBlackjack:
                return playerBlackjackSoundNames
            case .dealerBlackjack:
                return dealerBlackjackSoundNames
            case .playerBust:
                return playerBustSoundNames
            case .dealerBust:
                return dealerBustSoundNames
            case .playerWin:
                return playerWinSoundNames
            case .dealerWin:
                return dealerWinSoundNames
            case .tie:
                return tieSoundNames
        }
    }
    
    func randomSoundName(forOutcome outcome: Outcome) -> String {
        /// For the given game Outcome, return a random soundName
        /// Avoid using the same sound twice in a row, if possible
        var soundName: String
        let possibleSoundNames = soundNameArray(forOutcome: outcome)
        repeat {
            soundName = possibleSoundNames.randomElement() ?? Theme.errorSoundName
            /// NOTE: if sound is the same as previous, pick again...
            /// ...unless there has been an error!
        } while (soundName == previousSoundName) && (soundName != Theme.errorSoundName)
        previousSoundName = soundName
        return soundName
    }
}



// MARK: - Theme
/// Actual Themes
/// Instantiate a Theme by passing an array of soundNames for each of the possible game Outcomes
/// To create a new theme, copy and rename "newThemeTemplate", then add the new sounds (for each outcome)...
/// ...and add it to theme(forPlayerScore:), with it's score range
extension Theme {

    static func theme(forPlayerScore playerScore: Int) -> Theme {
        /// For the given playerScore, return the appropriate Theme
        switch playerScore {
            
                
        case 0...9:
            return .homerBart
        case 10...19:
            return .arnieTrump
        case 20...29:
            return .deadpoolXavier
        case 30...39:
            return .powersEvil
        case 40...49:
            return .homerBart
        case 50...59:
            return .conneryMoore
        case 60...69:
            return .deniroPesci
        case 70...79:
            return .arnieTrump
        case 80...89:
            return .powersEvil
        case 90...99:
            return .deadpoolXavier
        case 100...109:
            return .conneryMoore
        case 110...119:
            return .homerBart
        case 120...129:
            return .deniroPesci
        case 130...139:
            return .arnieTrump
        case 140...149:
            return .conneryMoore
        case 150...159:
            return .deniroPesci
        case 160...169:
            return .deadpoolXavier
        case 170...179:
            return .powersEvil
        case 180...189:
            return .homerBart
        case 190...199:
            return .deadpoolXavier
        case 200...209:
            return .deniroPesci
        case 210...219:
            return .conneryMoore
        case 220...229:
            return .arnieTrump
        case 230...239:
            return .powersEvil
        case 240...249:
            return .homerBart
        case 250...259:
            return .deadpoolXavier
        case 260...269:
            return .conneryMoore
        case 270...279:
            return .deniroPesci
        case 280...289:
            return .arnieTrump
        case 290...299:
            return .powersEvil
            
            /// A new scheme would be added here, with it's score range
            /*
            case 100...119:
                return newTheme
            */
            default:
                return homerBart
        }
    }
    
    private static let conneryMoore =
        Theme(name: "Bond",
              playerBlackjackSoundNames: ["sc bk again + riff", "rm well d george", "sc whipped", "sc marx brothers", "sc cash", "sc bk domination", "sc bk again + chord",],
              dealerBlackjackSoundNames: ["rm my name sc original", "rm bj sc smug", "rm magnetism", "rm ego sc notice", "rm bj sc my line + riff"],
              playerBustSoundNames: ["live die", "just deal", "good god", "joined up letters", "sc shocking", "ppk"],
              dealerBustSoundNames: ["sc well played + riff", "sc bot lip", "sc bad luck dest + chord", "rm glass eye", "sc busted + chord", "sc galore", "rm team sc bon + riff", "sc blessings", "sc truelly bust + riff", "rm pity sc not darling", "rm pound sc pounding"],
              playerWinSoundNames: ["not tim", "beat sleep", "slik", "sc destiny", "sc well played + riff", "sc galore", "rm glass eye"],
              dealerWinSoundNames: ["sc moonraker + riff", "rm perfect sc not darling", "rm writing sc crayon", "sc convincing"],
              tieSoundNames: ["rm cookie", "rm next hand sc not darling", "rm shake or stirred", "rm point sc god dam"])
    
    private static let arnieTrump =
        Theme(name: "ArnieTrump",
              playerBlackjackSoundNames: ["looks", "my seat2", "knicks", "daddy money", "cheeto", "whipped"],
              dealerBlackjackSoundNames: ["35 bj", "ping pong", "whitejack", "piss off", "chicken", "can i say bj", "whitejack", "blow mouth"],
              playerBustSoundNames: ["mail order", "winning not", "crayon", "on the chin", "move lips ah", "stupid", "food chain", "gooder", "teeth"],
              dealerBustSoundNames: ["be back da", "won again", "leather", "thick b", "my seat", "d duck", "lost conc", "russian"],
              playerWinSoundNames: ["lose better", "hilary desk", "not ripped", "chunky ass", "easy come", "you win im rich", "loose change", "whipped"],
              dealerWinSoundNames: ["stump up pb", "lose to donald", "rig it", "sarcasm", "hooker", "hilarys hand", "kings", "beat ass", "happy meal"],
              tieSoundNames: ["knicks", "rig it", "kings", "ping pong", "on the chin", "gooder"])
    
    private static let powersEvil =
        Theme(name: "Austin Powers",
              playerBlackjackSoundNames: ["69", "shagjack", "big blackjack", "shagjack again", "shagadelic", "batman", "groovy", "bjk in house", "blk bby", "blk sha", "shag on", "swinger"],
              dealerBlackjackSoundNames: ["gotta hurt", "not cool hate it", "bj fook me", "bj not again", "hand pick", "fookme not agn", "beehive", "ev mine agn","shine teeth"],
              playerBustSoundNames: ["bust come on", "bust dam it", "dick move", "grater", "fook me not again", "come on", "not again", "fookme", "oops", "ev bust agn", "ev jacket", "kidding"],
              dealerBustSoundNames: ["way i like", "bust baby", "good+bad", "fare", "win some", "hurt toots", "shedding", "tangoed", "wham bam"],
              playerWinSoundNames: ["mojo right", "shaguar", "mojo back", "yeah baby", "masterdebater", "not bad", "bad hair day", "compels", "ev pussy"],
              dealerWinSoundNames: ["mojo hit baby", "wintiny", "dealer wins", "woah", "bruised mojo", "cheetoing", "does hair", "ev candy", "ev plan"],
              tieSoundNames: ["low blow", "tie d wins", "def not cool", "behave", "tennis", "wife sha"])
    
    private static let deadpoolXavier =
        Theme(name: "Deadpool",
              playerBlackjackSoundNames: ["dp blk jk", "dp wham bam", "dp jimmy ch", "dp jimmy fn ch", "dp better blk jk ag", "x handsome", "dp xmas"],
              dealerBlackjackSoundNames: ["dp nice hand", "dp son of btch", "dp rock me", "dp god dam", "x bk jk jimmy", "x blk jk son of btch"],
              playerBustSoundNames: ["waffles", "dp logolas", "dp thats hard", "dp francis", "dp muffling", "dp helmet head", "dp ace kojak", "dp not again", "dp come on", "x reckless", "x too ugly"],
              dealerBustSoundNames: ["x cheese grt", "dp xmas", "dp see it cm", "dp make it so", "dp beatles", "dp beggars"], // TODO: , "dp better"],
              playerWinSoundNames: ["feotus", "x handsome", "dp big chrome", "dp luvs u bby", "x spok too long", "x logan"],
              dealerWinSoundNames: ["dp yesterday", "dp punch", "x perfectly", "x coming back", "dp francis", "dp ace kojak"],
              tieSoundNames: ["x natural order", "dp drive through", "dp punch", "dp god dam"])
    
    
    
    private static let homerBart =
        Theme(name: "simpsons",
              playerBlackjackSoundNames: ["hs miracle", "hs jackback", "hs mumble bj", "bs eat shorts", "hs r us sure not rules"],
              dealerBlackjackSoundNames: ["bs carumba", "bs was jack black", "bs el barto", "bs card shark", "bs loser ville"],
              playerBustSoundNames: ["bs bad luck", "bs homer run", "bs nice 1 keep comin", "hs gonna burn", "bs pieman", "hs chore monkey"],
              dealerBustSoundNames: ["hs read weep", "hs sore loser", "bs not again woohoo", "hs lessons", "hs barthom hpy", "bs that sucks"],
              playerWinSoundNames: ["hs win sing", "hs r u cheating", "hs love game", "hs suck it up lb", "hs zippy"],
              dealerWinSoundNames: ["hs barthom lose", "bs card shark si", "hs crying", "bs cowabunga + homer run", "bs loser man sung"],
              tieSoundNames: ["bs lessons", "hs pie man tie", "bs doughnuts", "bs big loser"])
    
    
    
    
    
    
    private static let deniroPesci =
        Theme(name: "goodfellows",
              playerBlackjackSoundNames: ["rd bj again", "rd what know", "rd cards not thing", "jp mad max", "jp gotta b kdn me"],
              dealerBlackjackSoundNames: ["rd tinkerbell", "rd lky mth fock", "rd mother story", "jp casket"],
              playerBustSoundNames: ["rd bonsai", "jp whatever", "rd leo stop pk", "jp focker out"],
              dealerBustSoundNames: ["rd jack left","rd say something ss", "jp mu fu", "jp ok ok"],
              playerWinSoundNames: ["jp gotta b kdn me", "jp ok ok", "jp take up", "jp mu fu"],
              dealerWinSoundNames: ["jp smoke", "rd god dam", "jp off u f", "rd smug"],
              tieSoundNames: ["rd stupid rule", "rd pencil", "jp 1 way another"])
    
    
    /// To add a new theme, duplicate and rename this template, then add the new sounds (for each outcome)...
    /// Note that each array **must** contain **more than one** sound!
    /*
    private static let newThemeTemplate =
        Theme(name: "EnterThemeName",
              playerBlackjackSoundNames: [],
              dealerBlackjackSoundNames: [],
              playerBustSoundNames: [],
              dealerBustSoundNames: [],
              playerWinSoundNames: [],
              dealerWinSoundNames: [],
              tieSoundNames: [])
    */
}



// MARK: - Theme
/// Utility / Test
extension Theme {
    
    /// **allThemes**
    /// An array of all the instantiated Themes
    /// Used for testing
    private static let allThemes: [Theme] = [Theme.conneryMoore, Theme.arnieTrump, Theme.powersEvil, Theme.deadpoolXavier, Theme.homerBart, Theme.deniroPesci]
    
    static func checkAllSoundFilesExist() {
        /// This function checks that all Theme sound files exist
        /// (Useful when adding or renaming sound files)
        /// For each Theme, for each soundName array, for each soundName...
        /// ...check that the file exists (log an error to console, if not)
        var count = 0
        print("Checking for missing sound files...")
        for theme in Theme.allThemes {
            for soundNameArray in [theme.playerBlackjackSoundNames,
                                   theme.dealerBlackjackSoundNames,
                                   theme.playerBustSoundNames,
                                   theme.dealerBustSoundNames,
                                   theme.playerWinSoundNames,
                                   theme.dealerWinSoundNames,
                                   theme.tieSoundNames] {
                for soundName in soundNameArray {
                    if let _ = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                        //print("  \(soundName)")
                    } else {
                        count += 1
                        print("  ERROR: Theme: \(theme.name), couldn't find: \(soundName)")
                    }
                }
            }
        }
        print("\(count == 0 ? "No m" : "M")issing sound files\(count > 0 ? ": \(count)" : "")")
    }
}


/*
 case 0...19:
     return conneryMoore
 case 20...39:
     return arnieTrump
 case 40...59:
     return powersEvil
 case 60...79:
     return deadpoolXavier
 case 80...99:
     return homerBart
 case 100...119:
     return deniroPesci
 
 */
