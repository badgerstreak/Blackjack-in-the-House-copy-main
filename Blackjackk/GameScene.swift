//
//  GameScene.swift
//  Blackjack in the house
//  ca-app-pub-4884640608131572~8241580814
//  Created by Joe Curran on 30/05/2020.
//  Copyright © 2020 Badgerstreak. All rights reserved.
//

import SpriteKit
import AVFoundation
import Foundation

var audioPlayer:AVAudioPlayer?
var button:UIButton!
var bgplayer:AVAudioPlayer?

class GameScene: SKScene {
    let moneyContainer = SKSpriteNode(color: .clear, size: CGSize(width:250, height: 150))
    let dealBtn = SKSpriteNode(imageNamed: "deal_btn")
    let hitBtn = SKSpriteNode(imageNamed: "hit_btn")
    let standBtn = SKSpriteNode(imageNamed: "stand_btn")
    let instructionText = SKLabelNode(text: "Place your bet")
    let player1 = Player(hand: Hand(),bank: Bank())
    let dealer = Dealer(hand: Hand())
    var allCards = [Card]()
    let dealerCardsY = 830
    let playerCardsY = 200
    var currentPlayerType:GenericPlayer = Player(hand: Hand(),bank: Bank())
    var playerYields = false
    let deck = Deck()
    let musicPlayer = MusicPlayer()
    var playerScore = 0   {
        didSet {
            theme = Theme.theme(forPlayerScore: playerScore)
            let newTableType = TableType.for(playerScore: playerScore)
            //Call `replaceTable()` only on `tableType` did change
            if tableType != newTableType {
                tableType = newTableType
                replaceTable()
            }
        }
    }

    let playerLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var dealSscore = 0
    let dealerLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    let table = SKSpriteNode(imageNamed: "moes bar")
    var currentTable: SKSpriteNode?
    
    var tableType: TableType = .ovaloffice
    
    /// 2020-11-10 Rob
    var theme = Theme.theme(forPlayerScore: 0)

    override func didMove(to view: SKView) {
        setupTable()
        setupButtons()
        currentPlayerType = player1
        //musicPlayer.startBackgroundMusic(sound: "playlistbj", type: "mp3")
        didTapButton()
    }

    
    
    
    func replaceTable() {
        //add delay between table change
        let secondsToDelay = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) { [self] in
           
        // remove existing `table` before adding new one
            if let table = currentTable {
            table.removeFromParent()
                self.currentTable = nil
            
        }
            let table = SKSpriteNode(imageNamed: self.tableType.imageName)
            self.addChild(table)
            table.position = CGPoint(x: size.width/2, y: size.height/2)
            table.zPosition = -1
        
        
        switch tableType {
            case .bond:
                //...
                break
            case .ovaloffice:
                //...
                break
            case .austin:
                //...
                break
            case .deadpool:
                //...
                break
            case .moesbar:
                //...
                break
            case .casino:
                //...
                break
        
        }
    }
    
    }
    
    
    
    func setupTable(){
        
        addChild(table)
        table.position = CGPoint(x: size.width/2, y: size.height/2)
        table.zPosition = -1
        
        //  replaceTable()
        
        addChild(moneyContainer)
        moneyContainer.anchorPoint = CGPoint(x:0, y:0)
        moneyContainer.position = CGPoint(x:size.width/2 - 125, y:size.height/2)
        instructionText.fontColor = UIColor.red
        instructionText.fontName = "AvenirNext-Bold"
        addChild(instructionText)
        instructionText.position = CGPoint(x: size.width/2, y: 400)  
        deck.new()
        
        
        playerLabel.text = "Player: 0"
        playerLabel.fontSize = 30
        playerLabel.fontColor = SKColor.red
        playerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        playerLabel.position = CGPoint(x: 350, y: 300)  // 350   360
        playerLabel.zPosition = 100
        addChild(playerLabel)
        
        dealerLabel.text = "Dealer: 0"
        dealerLabel.fontSize = 30
        dealerLabel.fontColor = SKColor.red
        dealerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        dealerLabel.position = CGPoint(x: 340, y: 660)  // was 300   660
        dealerLabel.zPosition = 100
        addChild(dealerLabel)
    }
    
    func addPlayerScore() {
        playerScore += 1
        playerLabel.text = "Player: \(playerScore)"
    }
    
    func addDealerScore(){
        dealSscore += 1
        dealerLabel.text = "Dealer: \(dealSscore)"
    }

    func setupButtons(){
        dealBtn.name = "dealBtn"
        addChild(dealBtn)
        dealBtn.color = .red
        dealBtn.colorBlendFactor = 0.4
        dealBtn.position = CGPoint(x:250, y:40)
        
        hitBtn.name = "hitBtn"
        addChild(hitBtn)
        hitBtn.color = .white
        hitBtn.colorBlendFactor = 0.4
        hitBtn.position = CGPoint(x:375, y:40)
        hitBtn.isHidden = true
        
        standBtn.name = "standBtn"
        addChild(standBtn)
        hitBtn.color = .white
        hitBtn.colorBlendFactor = 0.4
        standBtn.position = CGPoint(x:525, y:40)
        standBtn.isHidden = true
        
        button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width / 3, height: 30)
        button.center = CGPoint(x:205, y:50)
        button.setTitle("music", for: UIControl.State.normal)
        button.backgroundColor = UIColor.darkGray
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: UIControl.Event.touchUpInside)
        
        self.view!.addSubview(button)
    }

    @objc func didTapButton(){
        if let player = bgplayer, player.isPlaying{
            //stop playback
            button.setTitle("play", for: .normal)
            player.pause()
        }
        else {
            //set up player, and play
            button.setTitle("pause", for: .normal)
            let urlString = Bundle.main.path(forResource: "playlistbj", ofType: "mp3")
            
            do{
                if #available(iOS 10.0, *) {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
                } else {
                    
                }
                print("Playback ok")
                try AVAudioSession.sharedInstance().setActive(true)
                print("session is active")
                
                guard let urlString = urlString else{
                    return
                }
                bgplayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = bgplayer else{
                    return
                }
                
                player.play()
            }
            catch {
                print ("oops")
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        
        
        if(touchedNode.name == "dealBtn"){
            deal()
            //  dealArray()
            //deal array here
        }
        
        if(touchedNode.name == "hitBtn"){
            hit()
            //hit array here
        }
        
        if(touchedNode.name == "standBtn"){
            stand()
            //stand array here
        }
    }
    
    func deal() {
        instructionText.text = ""
        dealBtn.isHidden = true;
        standBtn.isHidden = false
        hitBtn.isHidden = false
        let tempCard = Card(suit: "card_front", value: 0)
        tempCard.position = CGPoint(x:630, y:980)
        addChild(tempCard)
        tempCard.zPosition = 100
        
        let newCard = deck.getTopCard()
        
        var whichPosition = playerCardsY
        var whichHand = player1.hand
        if(self.currentPlayerType is Player){
            whichHand = player1.hand
            whichPosition = playerCardsY;
        } else {
            whichHand = dealer.hand
            whichPosition = dealerCardsY;
        }
        
        whichHand.addCard(card: newCard)
        let xPos = 250 + (whichHand.getLength()*35)
        let moveCard = SKAction.move(to: CGPoint(x:xPos, y: whichPosition),duration: 1.00) // TODO: 1.0)
        tempCard.run(moveCard, completion: { [unowned self] in
            self.player1.setCanBet(canBet: true)
            if(self.currentPlayerType is Dealer && self.dealer.hand.getLength() == 1){
                self.dealer.setFirstCard(card: newCard)
                self.allCards.append(tempCard)
                tempCard.zPosition = 0
            } else {
                tempCard.removeFromParent()
                self.allCards.append(newCard)
                self.addChild(newCard)
                newCard.position = CGPoint( x: xPos, y: whichPosition)
                newCard.zPosition = 100
            }
            if(self.dealer.hand.getLength() < 2){
                if(self.currentPlayerType is Player){
                    self.currentPlayerType = self.dealer
                }else{
                    self.currentPlayerType = self.player1
                }
                self.deal()
            }else if (self.dealer.hand.getLength() == 2 && self.player1.hand.getLength() == 2) {
                if(self.player1.hand.getValue() == 21 || self.dealer.hand.getValue() == 21){
                    self.doGameOver(hasBlackJack: true)
                } else {
                    self.standBtn.isHidden = false;
                    self.hitBtn.isHidden = false;
                }
            }
            
            if(self.dealer.hand.getLength() >= 3 && self.dealer.hand.getValue() < 17){
                self.deal();
            } else if(self.player1.isYeilding() && self.dealer.hand.getValue() >= 17){
                self.standBtn.isHidden = true
                self.hitBtn.isHidden = true
                self.doGameOver(hasBlackJack: false)
            }
            if(self.player1.hand.getValue() > 21){
                self.standBtn.isHidden = true;
                self.hitBtn.isHidden = true;
                self.doGameOver(hasBlackJack: false);
            }
        })
    }
    
    func doGameOver(hasBlackJack: Bool){
        hitBtn.isHidden = true
        standBtn.isHidden = true
        let tempCardX = allCards[1].position.x
        let tempCardY = allCards[1].position.y
        let tempCard = dealer.getFirstCard()
        addChild(tempCard)
        allCards.append(tempCard)
        tempCard.position = CGPoint(x:tempCardX,y:tempCardY)
        tempCard.zPosition = 0

        /// 2020-11-10 Rob
        if let outcome = Outcome.forPlayer(player1, dealer: dealer) {
            /// game finished, with outcome
            let soundName = theme.randomSoundName(forOutcome: outcome)
            print("soundName: \(soundName)")
            playSound(named: soundName)

            instructionText.text = outcome.instructionText
            
            if outcome.playerWon {
                moveMoneyContainer(position: playerCardsY)
                addPlayerScore()
            } else {
                moveMoneyContainer(position: dealerCardsY)
                addDealerScore()
            }
        }
    }

    func moveMoneyContainer(position: Int){
        let moveMoneyContainer = SKAction.moveTo(y: CGFloat(position), duration: 3.0)
        moneyContainer.run(moveMoneyContainer, completion: { [unowned self] in
            self.resetMoneyContainer()
        });
    }

    func resetMoneyContainer(){
        //Remove all card from coin container
        moneyContainer.removeAllChildren()
        moneyContainer.position.y = size.height/2
        newGame()
    }
    
    func newGame(){
        currentPlayerType = player1
        deck.new()
        instructionText.text = "PRESS DEAL";
        
        dealBtn.isHidden = false
        player1.hand.reset()
        dealer.hand.reset()
        player1.setYielding(yields: false)
        
        for card in allCards{
            card.removeFromParent()
        }
        
        allCards.removeAll()
    }
    
    func hit(){
        if(player1.getCanBet()){
            currentPlayerType = player1
            deal()
            player1.setCanBet(canBet: false)
        }
        // hitArray()
    }

    func stand(){
        player1.setYielding(yields: true)
        standBtn.isHidden = true
        hitBtn.isHidden = true
        if(dealer.hand.getValue() < 17){
            currentPlayerType = dealer
            deal();
        }else{
            doGameOver(hasBlackJack: false)
        }
        // stickSoundArray()
    }
    
    func playSound(named soundName: String) {
        /// Play the named sound file (from the App Bundle)
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }
        catch {
            print(error)
        }
    }
}
