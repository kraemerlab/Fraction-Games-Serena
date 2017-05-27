//
//  SharkScene.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import SpriteKit

class SharkScene : SKScene {
    weak var viewController: SceneViewController!
    var timer = Timer()
    var score = 0
    var seconds = 120
    
    let fixedLeftPoint = CGPoint(x: 340, y: 200)
    let fixedCenterPoint = CGPoint(x: 520, y: 190)
    let fixedRightPoint = CGPoint(x: 730, y: 190)
    let fixedFarRightPoint = CGPoint(x: 930, y: 190)
    
    let mainCharacterPoint = CGPoint(x: 200, y: 370)
    
    let rulesTextPoint = CGPoint(x: 780, y: 410)
    
    let textLeftPoint = CGPoint(x: 490, y: 197)
    let textCenterPoint = CGPoint(x: 645, y: 197)
    let textRightPoint = CGPoint(x: 800, y: 197)
    let textFarRightPoint = CGPoint(x: 955, y: 197)
    
    var feedbackLabel = SKLabelNode()
    
    var pieVal:Double = 0.0
    var pizzaVal:Double = 0.0
    var lowest:Double = 0.0
    
    var feedbackText = ""
    
    var selectedNode = SKSpriteNode()
    var timerLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    
    var fractions = [Float(1):"1",Float(0.5):"1/2",Float(0.33):"1/3",Float(0.25):"1/4",Float(0.125):"1/8", Float(0.875):"7/8"]
    
    
    
    var hungry = true
    var bools = [true,false]
    
    var winningValChosen = false
    
    var winningNumbers = [Float]()
    var selectedNodes = [Float]()
    var positionNumbers = Dictionary<Float, CGPoint>()
    var currentNodes = Dictionary<String,Float>()
    var currentNumbers = [Float]()
    var winningNums = String()
    var winningList = [Float]()
    
    var combos = [[Float]]()
    var indexList = [Int]()
    
    var alreadyChosen = [Float]()
    
    var level = 1
    var countForLevel = 0
    
    var thresholdVal = Double()
    
    override init(size: CGSize){
        super.init(size: size)
        
        /* Setup your scene here */
        
        let bg = SKSpriteNode(imageNamed: "Kitchenbgtable.png")
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.name = nodeTypes.bg
        
        let sprite = SKSpriteNode(imageNamed:"shark.png")
        sprite.position = mainCharacterPoint
        sprite.name = nodeTypes.shark
        
        let plate1 = SKSpriteNode(imageNamed: "plate.png")
        let plate2 = SKSpriteNode(imageNamed: "plate.png")
        let plate3 = SKSpriteNode(imageNamed: "plate.png")
        let plate4 = SKSpriteNode(imageNamed: "plate.png")
        
        plate1.position = fixedLeftPoint
        plate2.position = fixedCenterPoint
        plate3.position = fixedRightPoint
        plate4.position = fixedFarRightPoint
        
        plate1.name = "plate"
        plate2.name = "plate"
        plate3.name = "plate"
        plate4.name = "plate"
        
        
        addChild(bg)
        addChild(sprite)
        addChild(plate1)
        addChild(plate2)
        addChild(plate3)
        addChild(plate4)
        
        loadLevel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLevel(){
        
        selectedNodes.removeAll()
        currentNodes.removeAll()
        combos.removeAll()
        indexList.removeAll()
        currentNumbers.removeAll()
        alreadyChosen.removeAll()
        positionNumbers.removeAll()
        winningNumbers.removeAll()
        
//        if (level != 3){
//            hungry = bools[randomNumber(0..<bools.count)]
//        } else {
//            hungry = true
//        }
        
        
        let counterPlate = SKSpriteNode(imageNamed: "plate.png")
        counterPlate.position = CGPoint(x: 470, y: 350)
        
        //let cakeImages:Dictionary<Double,[String]> = [0.125:["a_slice_of_strawberry_cake_by_cutekhay-d510haw.png"],0.875:["cherry-cake.png"]]
        
        
        feedbackLabel = SKLabelNode(fontNamed: fonts.mathlete)
        feedbackLabel.text = ""
        feedbackLabel.name = nodeTypes.label
        feedbackLabel.fontSize = 35
        feedbackLabel.fontColor = UIColor.black
        feedbackLabel.position = CGPoint(x: 280, y: 30)
        
        
        seconds = 120
        timerLabel = SKLabelNode(fontNamed: fonts.mathlete)
        timerLabel.text = "Time: \(seconds)"
        timerLabel.name = nodeTypes.label
        timerLabel.fontSize = 35.0
        timerLabel.position = CGPoint(x: 750,y: 450)
        
        scoreLabel = SKLabelNode(fontNamed: fonts.mathlete)
        scoreLabel.text = "Score: \(score)"
        scoreLabel.name = nodeTypes.label
        scoreLabel.fontSize = 35.0
        scoreLabel.position = CGPoint(x: 750,y: 480)
        
        addChild(counterPlate)

        
        addChild(feedbackLabel)

        addChild(timerLabel)
        addChild(scoreLabel)
    }
    
    func startTimer() {
        
//        let lesserFracs = ["1","1/2","7/8","3/4"]
//        let greaterFracs = ["1/3","1/4","1/8","1/2"]
        var fracs = [String]()
        
        if (level == 3){
            fracs = ["3/4", "2/3"]
        } else if (level == 2){
            fracs = ["1/2", "3/4", "2/3"]
        }
        else {
            fracs = ["1/3", "1/2", "3/4", "1/4", "2/3"]
        }
        
        let values = ["1/2":0.5,"1/3":0.33, "1/4":0.25, "2/3":0.66, "3/4":0.75, "7/8":0.875,"1/8":0.125]
        
        let fractionText = fracs[randomNumber(0..<fracs.count)]
//        if (hungry) {
//            fractionText = greaterFracs[randomNumber(0..<greaterFracs.count)]
//        } else {
//            fractionText = lesserFracs[randomNumber(0..<lesserFracs.count)]
//        }
        
        thresholdVal = values[fractionText]!
        
        var whole = ["wholepizza.png","CutPie.png" ]//, "Whole_cake.png"]
        
        let pieImages:Dictionary<Double,[String]> = [0.11:["19pie.png"] , 0.22:["29pie.png"], 0.33:["39pie.png"], 0.44: ["49pie.png", "49pie-1.png"], 0.77: ["79pie.png"]]//0.25:["pie-1-4.png","pie-2-4.png","pie-3-4.png"], 0.5: ["Halfpie.png"], 0.125: ["Eighthpie.png"]]
        
        let pizzaImages:Dictionary<Double,[String]> = [0.5:["slice1-2.png","slice2-2.png"],0.33:["slice1-3.png","slice2-3.png","slice3-3.png"],0.25:["slice1-4.png","slice2-4.png","slice3-4.png","slice4-4.png"],0.125:["slice1.png","slice2.png","slice3.png","slice4.png","slice5.png","slice6.png","slice7.png","slice8.png"]]
        
        var foodOptions = [pizzaImages, pieImages]//, cakeImages]
        
        let foodChoiceNumber = randomNumber(0..<whole.count)
        let wholeFood = SKSpriteNode(imageNamed: whole[foodChoiceNumber])
        wholeFood.position = CGPoint(x: 470, y: 370)
        wholeFood.name = sharkFoods.whole
        
        let foodOne = setNode(foodOptions[foodChoiceNumber], name: "food1")
        foodOne.position = fixedLeftPoint
        positionNumbers[currentNodes["food1"]!] = fixedLeftPoint
        
        let foodTwo = setNode(foodOptions[foodChoiceNumber], name: "food2")
        foodTwo.position = fixedCenterPoint
        positionNumbers[currentNodes["food2"]!] = fixedCenterPoint
        
        let foodThree = setNode(foodOptions[foodChoiceNumber], name: "food3")
        foodThree.position = fixedRightPoint
        positionNumbers[currentNodes["food3"]!] = fixedRightPoint
        
        let foodFour = setNode(foodOptions[foodChoiceNumber], name: "food4")
        foodFour.position = fixedFarRightPoint
        positionNumbers[currentNodes["food4"]!] = fixedFarRightPoint
        
        let rulesLabel = SKLabelNode(fontNamed: fonts.mathlete)
        var str = ""
        
        let foodName = foodChoiceNumber == 0 ? "pizza" : "pie"
        
        if (hungry){
            str = labelText.sharkHungry + fractionText + " of " + foodName
        }
        else {
            str = labelText.sharkFull + fractionText + " of " + foodName
        }
        
        rulesLabel.text = str
        rulesLabel.name = nodeTypes.label
        rulesLabel.fontSize = 30
        rulesLabel.fontColor = UIColor.white
        rulesLabel.position = rulesTextPoint
        
        let feedMostLabel = SKLabelNode()
        feedMostLabel.name = nodeTypes.label
        feedMostLabel.fontName = fonts.mathlete
        feedMostLabel.fontColor = UIColor.white
        feedMostLabel.fontSize = 30
        feedMostLabel.position = CGPoint(x: 780, y: 380)
        feedMostLabel.text = "Feed him the most he can eat!"
        
        let selectionLabel = SKLabelNode()
        
        selectionLabel.name = nodeTypes.label
        selectionLabel.fontName = fonts.mathlete
        selectionLabel.fontSize = 30
        selectionLabel.fontColor = UIColor.white
        selectionLabel.position = CGPoint(x: 780, y: 350)
        
        if (level == 2){
            selectionLabel.text = labelText.sharkTwo
        } else if (level == 3) {
            selectionLabel.text = labelText.sharkThree
        } else {
            selectionLabel.text = labelText.sharkOne
        }

        addChild(wholeFood)
        addChild(foodOne)
        addChild(foodTwo)
        addChild(foodThree)
        addChild(foodFour)
        addChild(rulesLabel)
        addChild(feedMostLabel)
        addChild(selectionLabel)

        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SharkScene.updateSeconds), userInfo: nil, repeats: true)
        
        viewController.startBtn.isHidden = true
    }
    
    func setNode(_ dict:Dictionary<Double,[String]>, name:String) -> SKSpriteNode {
        
        var keys = Array(dict.keys)
        var val = keys[randomNumber(0..<keys.count)]
        
        while (alreadyChosen.contains(Float(val))){
            val = keys[randomNumber(0..<keys.count)]
        }
        
        currentNodes[name] = Float(val)
        currentNumbers.append(Float(val))
        
        var imageOpts = dict[val]
        
        let img = imageOpts![randomNumber(0..<imageOpts!.count)]
        
        let node = SKSpriteNode(imageNamed:img)
        node.name = name
        
        alreadyChosen.append(Float(val))
        
        return node
        
    }
    
    func reset(){
        // reset all the labels
        enumerateChildNodes(withName: nodeTypes.label, using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "food1", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "food2", using: {node, stop in
            node.removeFromParent()
        })
        
        //
        enumerateChildNodes(withName: "food3", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: "food4", using: {node, stop in
            node.removeFromParent()
        })
        
        enumerateChildNodes(withName: sharkFoods.whole, using: {node, stop in
            node.removeFromParent()
        })
        enumerateChildNodes(withName: "circle", using: {node, stop in
            node.removeFromParent()
        })
    
        // winning boolean
        
        viewController.gameStarted = false
        viewController.startBtn.isHidden = false
        
        loadLevel()
    }
    
    func updateScore(){
        score+=10
        
        // update labels accordingly
        scoreLabel.text = "Score: \(score)"
    }
    
    func updateSeconds() {
        if(seconds > 0)
        {
            seconds -= 1
            timerLabel.text = "Time: \(seconds)"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        
        selectNodeForTouch(positionInScene)
    }
    
    func selectNodeForTouch(_ touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode is SKSpriteNode {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as! SKSpriteNode
                let nodeName = touchedNode.name!
                
                if (nodeName == "food1" || nodeName == "food2" || nodeName == "food3" || nodeName == "food4"){
                    
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(-4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(4.0), duration: 0.1)])
                    selectedNode.run(SKAction.repeatForever(sequence))
                    
                    selectedNodes.append(currentNodes[nodeName]!)
                    
                    if (selectedNodes.count == level){

                        if (isCorrect(Double(sum(selectedNodes)))){

                            feedbackText = "Great job, you picked correctly!"
                            feedbackLabel.text = feedbackText
                            countForLevel += 1
                            if countForLevel == 3{
                                level += 1
                                countForLevel = 0
                                if (level == 4){
                                    level = 1
                                }
                            }
                            
                            let comparsionSign = hungry ? ">" : "<"
                            let info = "Correct value selected on level \(level). All options: \(currentNumbers) Selected: \(selectedNodes) Fraction: \(thresholdVal) Comparsion: \(comparsionSign) Time elasped: \(120-seconds) "
                            viewController.writeToDatabase(info)
                            
                            updateScore()
                        } else {
                            feedbackText = "Sorry that wasn't the correct choice."
                            
                            for num in winningNumbers {
                                let circle = SKSpriteNode(imageNamed: "correct.png")
                                circle.position = positionNumbers[num]!
                                circle.name = "circle"
                                addChild(circle)
                            }
                            

                            
                            feedbackLabel.text = feedbackText
                            if (score > 0){
                                score -= 1
                            }
                            
                            scoreLabel.text = "Score: \(score)"
                            let comparsionSign = hungry ? ">" : "<"
                            let info = "Wrong value selected on level \(level). All options: \(currentNumbers) Selected: \(selectedNodes) Fraction: \(thresholdVal) Comparsion: \(comparsionSign) Time elasped: \(120-seconds) "
                            viewController.writeToDatabase(info)
                        }
                        timer.invalidate()
                        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(SharkScene.reset), userInfo: nil, repeats: false)
                        
                    } else if (nodeName == "plate"){
                        feedbackText = "Touch the food not the plate!"
                        feedbackLabel.text = feedbackText
                    }
                    
                    else {
                        feedbackText = "Select another food!"
                        feedbackLabel.text = feedbackText
                    }
                }
            }
        }
    }
    
    func degToRad(_ degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    func randomNumber(_ range: Range<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func sum(_ list: [Float]) -> Float {
        var sum = Float()
        let len = list.count
        
        if (len > 1){
            for i in 0...len-1 {
                sum = sum + list[i]
            }
        } else if (len == 1) {
            sum = list[0]
        } else {
            sum = 0.00
        }
        
        return sum
    }
    
    func combo( array: [Float], k: Int) -> [[Float]] {
        var array = array
        if k == 0 {
            return [[]]
        }
        
        if array.isEmpty {
            return []
        }
        
        let head = array[0]
        
        var ret = [[Float]]()
        var subcombos = combo(array: array, k: k - 1)
        for subcombo in subcombos {
            var sub = subcombo
            sub.insert(head, at: 0)
            ret.append(sub)
        }
        array.remove(at: 0)
        ret += combo(array: array, k: k)
        
        return ret
    }
    
    
    
    
    func getCombos(_ given: [Float],new:[Float],n:Int,k:Int){
        var new = new
        if (k==0){
            combos.append(new)
            
            new.removeAll()
            return
        }
        var i=n-k
        while (i<n){
            new.append(given[i])
            getCombos(given, new: new, n: n, k: k-1)
            
            i+=1
            
        }
    }
    
    func isEqual(listA: [Float], listB:[Float]) -> Bool {
        let A = listA.sorted(by: >)
        let B = listB.sorted(by: >)
        return A == B
    }
    
    func isCorrect(_ selectedValue:Double) -> Bool {
        let selected = Float(String(selectedValue))
        
        if (hungry){
            if (level == 1){
                let allNums = currentNumbers.sorted(by: >)
                let winner = getHighest(allNums)
                winningNumbers.append(winner)
                return selected! == winner
            } else {
                let winningSums = getWinnningSumList()
//                NSLog("SELECTED NODES: \(selectedNodes)")
                for num in winningSums {
                    winningNumbers.append(num)
                }
                return isEqual(listA: winningSums, listB: selectedNodes)
            }
            
        } /*else {
            if (level == 1){
                let allNums = currentNumbers.sorted(by: <)
                let winner = getLowest(allNums)
                return selected! == winner
            } else {
                let winningSums = getWinnningSumList(true)
                return winningSums == selectedNodes
            }
        }*/
        return false
    }
    
    /*func getLowest(_ numArray:[Float]) -> Float {
        
        let winningVal = Float(String(thresholdVal))
        for num in numArray {
            if (num <=  winningVal!){
                return num
            }
        }
        return 0
    }*/
    
    // set hungry always to true so its always highest?
    func getHighest(_ numArray:[Float]) -> Float {
        
        let winningVal = Float(String(thresholdVal))
        var currentHighest = Float()
        for num in numArray {
            if (num <= winningVal! && num > currentHighest){
                currentHighest = num
            }
        }
        NSLog("THE RIGHT ANSWER IS \(currentHighest)")
        return currentHighest
    }
    
   /* func getCorrectVal(_ isHungry:Bool) -> Float {
        if (level == 1 && isHungry){
            winningNums = String(currentNumbers.max()!)
            return currentNumbers.max()!
        } else if (level == 1 && !isHungry){
            winningNums = String(currentNumbers.min()!)
            return currentNumbers.min()!
        } else {
            let list = getWinnningSumList(isHungry)
            winningNums = String(describing: list)
            return sum(list)
        }
    }*/
    
    func getCorrectCombos(array: [Float], k: Int) -> [[Float]]{
        var result = [[Float]]()
        let combinations = combo(array: array, k: k)
        var prev = [Float]()
        
        for arr in combinations {
            var include = true
            prev.append(arr[0])
            var i = 1
            while (i < arr.count){
                if (prev.contains(arr[i]) ){
                    include = false
                    break
                }
                prev.append(arr[i])
                i += 1
            }
            if (include){
                result.append(arr)
            }
            
            prev.removeAll()
        }
        return result
    }
    
    func getWinnningSumList() -> [Float] {
        let list = [Float]()
//        NSLog("CURRENT NUMBERS: \(currentNumbers)")
        getCombos(currentNumbers, new: list, n: currentNumbers.count, k: level)
//        NSLog("COMBOS ARE: \(getCorrectCombos(array: currentNumbers, k: level))")
        let allCombos = getCorrectCombos(array: currentNumbers, k: level)
        NSLog("WINNING COMBO IS: \(allCombos[getAllSums(allCombos)])")
        return allCombos[getAllSums(allCombos)]
    }
    
     func getAllSums(_ listOfLists:[[Float]]) -> Int {
        var sums = [Float]()
        var i=0
        
        while (i<listOfLists.count-1) {
            sums.append(sum(listOfLists[i]))
            i += 1
        }
        
        
        let highest = getHighest(sums)
        if (highest == 0.0){
            return 0
        }
        let index = sums.index(of: highest)
        return index!

       /*if (low){
            let lowest = sums.min()
            let index = sums.index(of: lowest!)
            return index!
        } else {
            let highest = sums.max()
            let index = sums.index(of: highest!)
            return index!
        } */
    }
}
