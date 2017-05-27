//
//  CandyMonsterScene.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import SpriteKit

class CandyMonsterScene : SKScene {
    weak var viewController: SceneViewController!
    
    var started = false
    
    var fullBag = SKSpriteNode()
    var bagOne = SKSpriteNode()
    var bagTwo = SKSpriteNode()
    var bagThree = SKSpriteNode()
    var timer = Timer()
    
    var level = 1
    var numberInBag = Int()
    var countForLevel = 0
    
    var winningBag = CGPoint()
    var winningPile = Int()
    
    var seconds = 120
    var timerLabel = SKLabelNode()
    
    let numberOpts = [3,6,8,9,11,12,13,17,18,19,21,22,24,27]
    
    let bagsDict = [3:"Bag3.png", 6: "Bag6.png", 8: "Bag8.png", 9: "Bag9.png", 11: "Bag11.png", 12: "Bag12.png", 13: "Bag13.png", 17: "Bag17.png", 18: "Bag18.png", 19: "Bag19.png", 21: "Bag21.png", 22: "Bag22.png", 24: "Bag24.png", 27: "Bag27.png"]
    
    let candyDict = [3:"candy3.png", 6: "candy6.png", 8: "candy8.png", 9: "candy9.png", 11: "candy11.png", 12: "candy12.png", 13: "candy13.png", 17: "candy17.png", 18: "candy18.png", 19: "candy19.png", 21: "candy21.png", 22: "candy22.png", 24: "candy24.png", 27: "candy27.png"]
    
    var positionsOfBags = Dictionary<CGFloat, Int>()
    
    override init(size: CGSize){
        super.init(size: size)
        let bg = SKSpriteNode(imageNamed: "candy_background.png")
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.name = "background"
        bg.isUserInteractionEnabled = false
        
        addChild(bg)
        
    }
    
    func startPressed() {
        if (viewController != nil){
            viewController.startBtn.isHidden = true
        }
        started = true
        loadGame()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     have dictionary(for bags) with key as number, value as image name for bag
     dictionary for candy
     make list of chosen already
     then put 30-key image association
     then select two other random that are not the winning value
    */
    
    func loadGame(){
        
        NSLog("Load game called.")
    
        fullBag = SKSpriteNode(imageNamed: "Open_candy_bag.png")
        fullBag.position = CGPoint(x: 480, y: 290)
        fullBag.name = "full bag"
        fullBag.isUserInteractionEnabled = false
        
        let intialInstruction = SKSpriteNode(imageNamed: "instruction_first.png")
        intialInstruction.position = CGPoint(x: 200, y: 475)
        intialInstruction.name = "Initial instruction"
        intialInstruction.isUserInteractionEnabled = false
        
        addChild(fullBag)
        addChild(intialInstruction)

        
        let triggerTime = (Int64(NSEC_PER_SEC) * 5)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.bagDisappear()
        })
    }
    
    func bagDisappear(){
        enumerateChildNodes(withName: "full bag", using: {node, stop in
            node.removeFromParent()
        })
    
        enumerateChildNodes(withName: "Initial instruction", using: {node, stop in
            node.removeFromParent()
        })
        
        numberInBag = numberOpts[randomNumber(0..<numberOpts.count)]
        let emptyBag = SKSpriteNode(imageNamed: bagsDict[numberInBag]!)
        emptyBag.position = CGPoint(x: 480, y: 290)
        emptyBag.name = "empty bag"
        
        let instruction = SKSpriteNode(imageNamed: "instruction.png")
        instruction.position = CGPoint(x: 200, y: 475)
        instruction.name = nodeTypes.label
    
        seconds = 120
        timerLabel = SKLabelNode(fontNamed: fonts.mathlete)
        timerLabel.text = "Time: \(seconds)"
        timerLabel.name = nodeTypes.label
        timerLabel.fontSize = 40.0
        timerLabel.position = CGPoint(x: 650,y: 400)
        timerLabel.fontColor = UIColor.black
        
        addChild(emptyBag)
        addChild(instruction)
        addChild(timerLabel)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MonkeyScene.updateSeconds), userInfo: nil, repeats: true)
        
        showCandy()
    }
    
    func showCandy(){
        
        var limitedNumberOpts = numberOpts
        
        var index = limitedNumberOpts.index(of: 30-numberInBag)
        limitedNumberOpts.remove(at: index!)
        
        var pileOpts = [Int]()
        pileOpts.append(30-numberInBag)
        winningPile = 30 - numberInBag
        
        var randomOpt = getOffsetByLevel(winningPile, nodeNumber: 1, chosenValues: pileOpts)//limitedNumberOpts[randomNumber(0..<limitedNumberOpts.count)]
        pileOpts.append(randomOpt)
        
        index = limitedNumberOpts.index(of: randomOpt)
        limitedNumberOpts.remove(at: index!)
        
        randomOpt = getOffsetByLevel(winningPile, nodeNumber: 2, chosenValues: pileOpts)//limitedNumberOpts[randomNumber(0..<limitedNumberOpts.count)]
        pileOpts.append(randomOpt)
        
        NSLog("Number in bag: %i Pile: \(String(describing: pileOpts)) ", numberInBag )
        
        var pile = pileOpts[randomNumber(0..<pileOpts.count)]
        if (pile == 30-numberInBag){
            winningBag = CGPoint(x: 350, y:65)
        }
        bagOne = SKSpriteNode(imageNamed: candyDict[pile]!)
        bagOne.position = CGPoint(x: 350, y:65)
        positionsOfBags[bagOne.position.x] = pile
        bagOne.name = "pile"
        index = pileOpts.index(of: pile)
        pileOpts.remove(at: index!)
        
        pile = pileOpts[randomNumber(0..<pileOpts.count)]
        if (pile == 30-numberInBag){
            winningBag = CGPoint(x: 680, y: 100)
        }
        bagTwo = SKSpriteNode(imageNamed: candyDict[pile]!)
        bagTwo.position = CGPoint(x: 680, y: 100)
        positionsOfBags[bagTwo.position.x] = pile
        bagTwo.name = "pile"
        index = pileOpts.index(of: pile)
        pileOpts.remove(at: index!)
        
        pile = pileOpts[randomNumber(0..<pileOpts.count)]
        if (pile == 30-numberInBag){
            winningBag = CGPoint(x: 900, y: 245)
        }
        bagThree = SKSpriteNode(imageNamed: candyDict[pile]!)
        bagThree.position = CGPoint(x: 900, y: 245)
        positionsOfBags[bagThree.position.x] = pile
        bagThree.name = "pile"
        
        addChild(bagOne)
        addChild(bagTwo)
        addChild(bagThree)
    }
    
    func getOffsetByLevel(_ chosenPile: Int, nodeNumber: Int, chosenValues:[Int]) -> Int {
        var offset = Int()
        
        if (level == 1) {
            offset = 10
            
        } else if (level == 2) {
            offset = nodeNumber == 1 ? 6 : 10
        } else if (level == 3) {
            offset = nodeNumber == 1 ? 3 : 6
            
        } else if (level == 4) {
            offset = 3
        }
        return selectPileByLevel(offset, chosenPile: chosenPile, chosenValues: chosenValues)
    }
    
    func selectPileByLevel(_ offset:Int, chosenPile: Int,chosenValues:[Int]) -> Int {
        for num in numberOpts {
            if (num >= chosenPile-offset && !chosenValues.contains(num)){
                return num
            }
        }
        return 0
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        
        selectNodeForTouch(positionInScene)
    }
    
    func selectNodeForTouch(_ touchLocation: CGPoint) {

        let touchedNode = self.atPoint(touchLocation)
        
        enumerateChildNodes(withName: nodeTypes.label, using: {node, stop in
            node.removeFromParent()
        })
        
        if (touchedNode is SKSpriteNode && started) {
            let nodePos = touchedNode.position
            
            if (nodePos == winningBag){
                let correct = SKLabelNode(fontNamed: fonts.mathlete)
                correct.text = "You selected the correct pile!"
                correct.fontSize = 60
                correct.fontColor = UIColor.black
                correct.position = CGPoint(x:460,y:600)
                correct.name = nodeTypes.label
                
                let info = "Correct value selected on level \(level). Winning bag: \(positionsOfBags[winningBag.x]) Selected: \(positionsOfBags[nodePos.x]) Time elasped: \(120-seconds)"
                viewController.writeToDatabase(info)
                addChild(correct)
                countForLevel += 1
                if countForLevel == 3{
                    level += 1
                    countForLevel = 0
                    if (level == 4){
                        level = 1
                    }
                }
                timer.invalidate()
                
                let triggerTime = (Int64(NSEC_PER_SEC) * 5)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    self.reset()
                    self.viewController.playAgainBtn.isEnabled = true
                    self.viewController.playAgainBtn.isHidden = false
                })
                
                
            } else if (touchedNode.name == "pile"){
                let incorrect = SKLabelNode(fontNamed: fonts.mathlete)
                incorrect.text = "You selected the incorrect pile. Correct pile circled."
                incorrect.fontSize = 50
                incorrect.fontColor = UIColor.black
                incorrect.position = CGPoint(x:460,y:580)
                incorrect.name = nodeTypes.label
                
                let info = "Wrong value selected on level \(level). Winning bag: \(positionsOfBags[winningBag.x]) Selected: \(positionsOfBags[nodePos.x]) Time elasped: \(120-seconds)"
                viewController.writeToDatabase(info)
                addChild(incorrect)
                
                let circle = SKSpriteNode(imageNamed: "correct.png")
                circle.position = winningBag
                circle.name = "circle"
                addChild(circle)
                
                timer.invalidate()
                
                let triggerTime = (Int64(NSEC_PER_SEC) * 7)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    self.reset()
                    self.viewController.playAgainBtn.isEnabled = true
                    self.viewController.playAgainBtn.isHidden = false
                })
            }
            
           
        }
    }
    
    // play again
    func playAgain(){
        loadGame()
        self.viewController.playAgainBtn.isEnabled = false
        self.viewController.playAgainBtn.isHidden = true
    }
    
    func reset(){
        enumerateChildNodes(withName: "empty bag", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "label", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "full bag", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "Initial instruction", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "pile", using: {node, stop in
            node.removeFromParent()
        })
        enumerateChildNodes(withName: "circle", using: {node, stop in
            node.removeFromParent()
        })
        
        
    }
    
    
    func updateSeconds() {
        if(seconds > 0)
        {
            seconds -= 1
            timerLabel.text = "Time: \(seconds)"
        }
     }
    
    func randomNumber(_ range: Range<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
}
