//
//  GameViewController.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class StartViewController: UIViewController, UITextFieldDelegate {
    var currentGame : String!

    // IBOutlets
    @IBOutlet weak var monkeyCharacterBtn: UIButton!
    
    @IBOutlet weak var sharkCharacterBtn: UIButton!
    
    @IBOutlet weak var monsterCharacterBtn: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    var userid = "test" as String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "monkeySegue"){
            currentGame = characters.monkey
            
        } else if (segue.identifier == "sharkSegue") {
            currentGame = characters.shark
            
        } else if (segue.identifier == "monsterSegue") {
            currentGame = characters.candyMonster
        }
        
        let sceneController : SceneViewController = segue.destination as! SceneViewController
        
        sceneController.userid = userid
        
        sceneController.gameSelected = currentGame
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        userid = textField.text
        return true
    }


}

