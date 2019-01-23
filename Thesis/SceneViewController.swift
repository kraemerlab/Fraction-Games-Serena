//
//  SceneViewController.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseDatabase

class SceneViewController : UIViewController {
    
    var userid : String!
    
    var currentScene : AnyObject!
    
    var gameSelected : String!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var useridLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    @IBOutlet weak var startBtn: UIButton!
    
    var gameStarted : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useridLabel.text = userid
        

        gameStarted = false
        
        if let view = self.view as! SKView? {
            view.showsNodeCount = false
            
            if gameSelected == characters.monkey
            {
                startBtn.isHidden = false
                startBtn.isEnabled = true
                let scene = MonkeyScene(size: view.frame.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                    
                // Present the scene
                view.presentScene(scene)
                    
                scene.viewController = self
                
                currentScene = scene
                
            
            } else if gameSelected == characters.shark
            {
                startBtn.isHidden = false
                startBtn.isEnabled = true
                
                let scene = SharkScene(size: view.frame.size)
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                    
                // Present the scene
                view.presentScene(scene)
                    
                scene.viewController = self
                
                currentScene = scene
                
            } else if gameSelected == characters.candyMonster
            {
                startBtn.isHidden = false
                startBtn.isEnabled = true
                
                let scene = CandyMonsterScene(size: view.frame.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                    
                // Present the scene
                view.presentScene(scene)
                    
                scene.viewController = self
                
                currentScene = scene
            
            }
        }
    }
    
    
    @IBAction func playAgainPressed(_ sender: Any) {
        if gameSelected == characters.candyMonster
        {
            let candyMonsterScene = currentScene as! CandyMonsterScene
            candyMonsterScene.playAgain()
        }
    }
    
    
    
    @IBAction func startBtnPressed(_ sender: AnyObject) {
        if gameSelected == characters.monkey && !gameStarted
        {
            let monkeyScene = currentScene as! MonkeyScene
            monkeyScene.startPressed()
            gameStarted = true
        }
        if gameSelected == characters.shark && !gameStarted
        {
            let sharkScene = currentScene as! SharkScene
            sharkScene.startTimer()
            gameStarted = true
        }
        if gameSelected == characters.candyMonster && !gameStarted
        {
            let candyMonster = currentScene as! CandyMonsterScene
            candyMonster.startPressed()
            gameStarted = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tutorialSegue"){
            let pageController : PageViewController = segue.destination as! PageViewController
            
            pageController.choosenCharacter = gameSelected
            pageController.userid = userid
            if(gameSelected == characters.candyMonster){
                let candyMonster = currentScene as! CandyMonsterScene
                startBtn.isHidden = false
                startBtn.isEnabled = true
                candyMonster.reset()
            }
        }
        if (segue.identifier == "backToStart"){
            let startController : StartViewController = segue.destination as! StartViewController
            startController.userid = userid
        }
    }
    
    func writeToDatabase(_ info: String){
        let date = NSDate()
        let rootRef = FIRDatabase.database().reference()
        let dataObj = DataObj(date: String(describing: date), info: info, game: gameSelected)
        let dataRef = rootRef.child(userid)
        dataRef.setValue(dataObj.toAnyObject())
//        let date = NSDate()
//        let rootRef = FIRDatabase.database().reference()
//        let dateRef = rootRef.child(String(describing: date))
//        let dataObj = DataObj(info: info, game: gameSelected)
//        let dataRef = dateRef.child(userid)
//        dataRef.setValue(dataObj.toAnyObject())
 
    }
    
}
