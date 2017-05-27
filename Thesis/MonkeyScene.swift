//
//  MonkeyScene.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import SpriteKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


enum ColliderType: UInt32 {
    case animal = 1
    case food = 2
}


class MonkeyScene : SKScene, SKPhysicsContactDelegate {
    weak var viewController: SceneViewController!
    
    var timer = Timer()
    var lastUpdateTime: TimeInterval = 0.0
    var dt: TimeInterval = 0.0
    var currentSpawnTime: TimeInterval = 5.0
    
    var score = 0
    var seconds = 120
    var bananasCollected = 0
    var level = 1
    var countForLevel = 0
    var thresholdVal = 0
    
    var bananaLabel = SKLabelNode()
    var timerLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    
    var bg = SKSpriteNode()
    var mainCharacter = SKSpriteNode()
    
    var gameOver = false
    var lost = false
    var bools = [true, false]
    
    let levelImages = [monkeyImages.bgOne, monkeyImages.bgTwo, monkeyImages.bgThree, monkeyImages.bgFour]
    
    var over = Bool()
    
    var points = [[CGPoint]]()
    var usedPoints = [CGPoint]()
    var limit = ""
    
    var monkey = Animal(imageNamed: monkeyImages.monkeyLeftImg)
    
    override init(size: CGSize){
        super.init(size: size)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        // Capture a tap
        
        loadLevel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLevel(){
        
        // points at which the bananas will spawn
        points = pointListsForLevels
        
        // threshold options
        let thresholds = [["1/2":530,"1/3":364, "1/4":255, "2/3":627, "3/4":783],
                          ["1/2":133,"3/4":220,"2":510, "3":752],
                          ["1/2":160,"3/4":220,"2":510,"3":752],
                          ["1/2":80,"1":130,"5":505,"8":785]]
        
        let currentVals = thresholds[level-1]
        let keys = Array(currentVals.keys)
        let randIndex = randomNumber(0..<keys.count)
        limit = keys[randIndex]
        thresholdVal = currentVals[limit]!
        
        
        
        // boolean of whether the objective will be to catch objects over or under a certain threshold
        over = bools[Int(arc4random_uniform(UInt32(bools.count)))]
        
        bananasCollected = 0
        
        bg = SKSpriteNode(imageNamed: levelImages[level-1])
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(bg)
        
        
        mainCharacter = monkey
        monkey.position = CGPoint(x: 200, y: 417)
        monkey.name = characters.monkey
        
        if (lost){
            score -= 1
            lost = false
        }
        
        scoreLabel = SKLabelNode(fontNamed: fonts.mathlete)
        scoreLabel.text = "Score: \(score)"
        scoreLabel.name = nodeTypes.label
        scoreLabel.fontSize = 40.0
        scoreLabel.position = CGPoint(x: 739,y: 515)
        scoreLabel.zPosition = 5
        
        seconds = 120
        timerLabel = SKLabelNode(fontNamed: fonts.mathlete)
        timerLabel.text = "Time: \(seconds)"
        timerLabel.name = nodeTypes.label
        timerLabel.fontSize = 40.0
        timerLabel.position = CGPoint(x: 739,y: 562)
        timerLabel.zPosition = 5
        
        let tipLabel = SKLabelNode(fontNamed: fonts.mathlete)
        tipLabel.text = labelText.morePoints
        tipLabel.name = nodeTypes.label
        tipLabel.fontSize = 30.0
        tipLabel.position = CGPoint(x: 400,y: 500)
        tipLabel.zPosition = 5
        
        let ruleLabel = SKLabelNode(fontNamed: fonts.mathlete)
        ruleLabel.text = labelText.collectBananas
        ruleLabel.fontSize = 30.0
        ruleLabel.name = nodeTypes.label
        ruleLabel.position = CGPoint(x: 400,y: 676)
        ruleLabel.zPosition = 5
        
        let rule = over ? labelText.greaterThan : labelText.lessThan
        let contRuleLabel = SKLabelNode(fontNamed: fonts.mathlete)
        contRuleLabel.fontSize = 30.0
        contRuleLabel.name = nodeTypes.label
        contRuleLabel.position = CGPoint(x: 400,y: 616)
        contRuleLabel.zPosition = 5
        contRuleLabel.text = "\(rule) \(limit)"
        
        bananaLabel = SKLabelNode(fontNamed: fonts.mathlete)
        bananaLabel.text = "Bananas Collected: \(bananasCollected)"
        bananaLabel.fontSize = 30.0
        bananaLabel.name = nodeTypes.label
        bananaLabel.position = CGPoint(x: 400,y: 550)
        bananaLabel.zPosition = 5
        
        addChild(monkey)
        addChild(scoreLabel)
        addChild(ruleLabel)
        addChild(contRuleLabel)
        addChild(timerLabel)
        addChild(tipLabel)
        addChild(bananaLabel)
        
        if (level > 1){
            startPressed()
        }
        
    }
    
    func spawnObject(_ node: SKSpriteNode, nodeName: String, positions: Array<Array<CGPoint>>, currentLevel: Int, spawnTime: Double) {
        var spawnTime = spawnTime
        if gameOver {
            return
        }
        
        spawnTime -= 0.2
        
        if spawnTime < 1.0 {
            spawnTime = 1.0
        }
        
        var randomIndex = Int(arc4random_uniform(UInt32(positions[level-1].count)))
        var pos = positions[level-1][randomIndex]
        
        // avoids having multiple bananas places on the same point
        while (usedPoints.contains(pos)){
            randomIndex = Int(arc4random_uniform(UInt32(positions[level-1].count)))
            pos = positions[level-1][randomIndex]
        }
        
        let newNode = node.mutableCopy() as! SKNode
        newNode.name = nodeName
        newNode.position = pos
        self.addChild(newNode)
        
        run(SKAction.sequence([SKAction.wait(forDuration: spawnTime), SKAction.run({
            self.spawnObject(node, nodeName: nodeName, positions: positions, currentLevel: currentLevel, spawnTime: spawnTime)} )]))
    }
    
    
    
    // checks if nodes collided with each other
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node
        
        if (firstNode?.physicsBody!.categoryBitMask > secondNode?.physicsBody?.categoryBitMask){
            handleCollision(firstNode,otherNode: secondNode)
        } else {
            NSLog("Unknown collision detected.")
        }
    }
    
    override func didMove(to view: SKView) {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MonkeyScene.handlePanFrom(_:)))
        self.view!.addGestureRecognizer(gestureRecognizer)
    }
    
    func handlePanFrom(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            if gameOver {
                restartGame()
            }
        } else if recognizer.state == .changed {
            var translation = recognizer.translation(in: recognizer.view!)
            translation = CGPoint(x: translation.x, y: -translation.y)
            self.panForTranslation(translation)
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
            
        } else if recognizer.state == .ended {
        }
    }
    
    func startPressed() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MonkeyScene.updateSeconds), userInfo: nil, repeats: true)
 
        currentSpawnTime = 1.4
        
        let banana = Food(imageNamed: monkeyImages.bananaImg)
        banana.name = nodeTypes.banana
        
        spawnObject(banana, nodeName: nodeTypes.banana, positions: points, currentLevel: level, spawnTime: currentSpawnTime)
        
        if (viewController != nil){
            viewController.startBtn.isHidden = true
        }
        
        
    }
    
    // moves the main character the user controls
    func panForTranslation(_ translation: CGPoint) {
        
        
        let position = mainCharacter.position
        if (position.x < 25 || position.x > 999 || position.y > 760 || position.y < 25 ){
            monkey.move(position.x + 10,y: position.y + 10)
        } else {
            monkey.move(position.x + translation.x,y: position.y + translation.y)
        }
    }
    
    func handleCollision(_ node: SKNode!, otherNode: SKNode!){
        var removeThese : [SKNode] = []
        
        if (((over && (Int(node.position.x) < thresholdVal)) || (!over && (Int(node.position.x) > thresholdVal))) || seconds == 0){
            let info = "Wrong value selected on level \(level). Threshold pos: \(thresholdVal) Selected pos: \(node.position) Fraction: \(limit) Time elasped: \(120-seconds)"
            viewController.writeToDatabase(info)
            gameEnds(false) }
        
        else if (bananasCollected > 8) {
            let info = "Won level \(level). Threshold pos: \(thresholdVal) Selected pos: \(node.position) Fraction: \(limit) Time elasped: \(120-seconds)"
            viewController.writeToDatabase(info)
            gameEnds(true)
        }

        // removes a node upon collision
        removeThese.append(node)
        removeChildren(in: removeThese)
        
        updateScore()
    }
    
    func updateScore(){
        bananasCollected += 1
        score += 1
        
        // update labels accordingly
        scoreLabel.text = "Score: \(score)"
        bananaLabel.text = "Bananas Collected: \(bananasCollected)"
    }
    
    func updateSeconds() {
        if(seconds > 0)
        {
            seconds -= 1
            timerLabel.text = "Time: \(seconds)"
        }
    }
    
    func convertScore(_ timeLeft: Int) -> Int {
        if (timeLeft > 100){
            return 3
        } else if (timeLeft > 50){
            return 2
        } else if (timeLeft > 10){
            return 1
        }
        return 0
    }
    
    func randomNumber(_ range: Range<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func gameEnds(_ won: Bool){
        //stop the timer
        timer.invalidate()
        gameOver = true
        
        let winningText = labelText.won
        let boundary = over ? labelText.under : labelText.over
        let losingText = "\(labelText.monkeyGameOver) \(boundary) \(limit)."
        
        let gameOverLabel = SKLabelNode(fontNamed: fonts.mathlete)
        
        if (won)
        {
            score += convertScore(seconds)
            gameOverLabel.text = winningText
            
            // highest level is 4
            countForLevel += 1
            if countForLevel == 3{
                level += 1
                countForLevel = 0
                if (level == 4){
                    level = 1
                }
            }
            /*
            if (level != 3){
                level += 1
            } else {
                level = 0
            }*/
        } else {
            lost = true
            gameOverLabel.text = losingText
        }
        
        gameOverLabel.name = nodeTypes.label
        gameOverLabel.fontSize = 35.0
        gameOverLabel.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0 + 20.0)
        gameOverLabel.zPosition = 5
        
        let tapLabel = SKLabelNode(fontNamed: fonts.mathlete)
        
        if (won) { tapLabel.text = labelText.monkeyAdvance }
        else { tapLabel.text = labelText.monkeyTryAgain }
        
        tapLabel.name = nodeTypes.label
        tapLabel.fontSize = 35.0
        tapLabel.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0 - 20.0)
        tapLabel.zPosition = 5
        
        addChild(gameOverLabel)
        addChild(tapLabel)
        
        viewController.startBtn.isHidden = false
        viewController.gameStarted = false
    }
    
    func restartGame() {
        // reset all the labels
        enumerateChildNodes(withName: nodeTypes.label, using: {node, stop in
            node.removeFromParent()
        })
        
        // get rid of all the bananas
        enumerateChildNodes(withName: nodeTypes.banana, using: {node, stop in
            node.removeFromParent()
        })
        
        // reset monkey character
        enumerateChildNodes(withName: characters.monkey, using: {node, stop in
            node.removeFromParent()
        })
        
        usedPoints.removeAll()
        gameOver = false
        loadLevel()
    }
}

