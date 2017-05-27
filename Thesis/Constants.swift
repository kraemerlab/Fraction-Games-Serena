//
//  Constants.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import Foundation
import UIKit

struct Characters {
    let monkey : String
    let shark : String
    let candyMonster : String
}

struct Scenes {
    let monkeyScene : String
    let sharkScene : String
    let monsterScene : String
}

struct MonkeyImages {
    let bgOne : String
    let bgTwo : String
    let bgThree : String
    let bgFour : String
    
    let monkeyLeftImg : String
    
    let bananaImg : String
    
    let startImg : String
    
}

struct NodeTypes {
    let label : String
    let banana : String
    let btn : String
    let shark : String
    let bg : String
}

struct Fonts {
    let labelFont : String
    let marker : String
    let mathlete : String
    
}

struct LabelText {
    let morePoints : String
    let collectBananas : String
    let greaterThan : String
    let lessThan : String
    let won : String
    let over : String
    let under : String
    let monkeyGameOver : String
    let monkeyAdvance : String
    let monkeyTryAgain : String
    let sharkHungry : String
    let sharkFull : String
    let sharkOne: String
    let sharkTwo : String
    let sharkThree : String
}

struct SharkFoods {
    let whole : String
    let pizza : String
    let pie : String
    let cake : String
}

struct TutorialImages {
    let dict : Dictionary<String,[String]>
}


let characters = Characters(monkey: "monkey", shark: "shark", candyMonster: "monster")

let tutorialDict = ["monkey":["monkey_tutorial1.png","monkey_tutorial2.png","monkey_tutorial3.png","monkey_tutorial4.png"], "shark":["shark_tutorial1.png","shark_tutorial2.png","shark_tutorial3.png"], "monster":["candy_tutorial1.png","candy_tutorial 2.png","candy_tutorial 3.png","candy_tutorial 4.png"]]

let tutorialImgs = TutorialImages(dict: tutorialDict)

let scenes = Scenes(monkeyScene: "MonkeyScene", sharkScene: "SharkScene", monsterScene: "CandyMonsterScene")

let nodeTypes = NodeTypes(label: "label", banana: "banana", btn: "button", shark: "shark", bg: "Background")

let fonts = Fonts(labelFont: "Thonburi-Bold", marker: "MarkerFelt-Wide", mathlete: "Mathlete-Bulky")

let labelText = LabelText(morePoints: "More points the faster you finish!", collectBananas: "Collect 10 bananas on a point", greaterThan: "greater than", lessThan: "less than", won: "You won!", over: "over", under: "under", monkeyGameOver: "Game over! You collected a banana that was", monkeyAdvance: "Move Suzie to advance levels!", monkeyTryAgain: "Move Suzie to try again.", sharkHungry: "Jo cannot eat more than ", sharkFull: " ", sharkOne: "Select one food!", sharkTwo: "Select two foods!", sharkThree: "Select three foods!")

// specific to shark game 

let sharkFoods = SharkFoods(whole: "whole", pizza: "pizza", pie: "pie", cake: "cake")

// specific to monkey game

let monkeyImages = MonkeyImages(bgOne: "background-1.png", bgTwo: "background-2.png", bgThree: "background-3.png", bgFour: "background-4.png", monkeyLeftImg: "monkey-left.png", bananaImg: "banana.png", startImg: "start.png")

// delete bananas on the perimeter

/* 
 1st CGPoint(x: 31, y: 133),CGPoint(x: 1005, y: 283),CGPoint(x: 975, y: 274)
 2nd CGPoint(x: 21, y: 131), CGPoint(x: 72, y: 132),, CGPoint(x: 955, y: 251), CGPoint(x: 998, y: 264)
 3rd CGPoint(x: 32, y: 126), CGPoint(x: 92, y: 132), , CGPoint(x: 940, y: 252), CGPoint(x: 997, y: 265)
 4th CGPoint(x: 32, y: 132), CGPoint(x: 77, y: 137), , CGPoint(x: 935, y: 258), CGPoint(x: 981, y: 266)
 
 */
let firstPointList : [CGPoint] = [CGPoint(x: 101, y: 133), CGPoint(x: 178, y: 134), CGPoint(x: 295, y: 136),
                                  CGPoint(x: 359, y: 143), CGPoint(x: 437, y: 151), CGPoint(x: 489, y: 158), CGPoint(x: 557, y: 163),
                                  CGPoint(x: 616, y: 175), CGPoint(x: 679, y: 188), CGPoint(x: 736, y: 205), CGPoint(x: 800, y: 221),
                                  CGPoint(x: 854, y: 234), CGPoint(x: 906, y: 251) ]

let secondPointList : [CGPoint] = [ CGPoint(x: 124, y: 135), CGPoint(x: 185, y: 135),
                                   CGPoint(x: 267, y: 136), CGPoint(x: 314, y: 141), CGPoint(x: 382, y: 145), CGPoint(x: 449, y: 155),
                                   CGPoint(x: 520, y: 163), CGPoint(x: 574, y: 171), CGPoint(x: 649, y: 183), CGPoint(x: 708, y: 196),
                                   CGPoint(x: 756, y: 205), CGPoint(x: 821, y: 216), CGPoint(x: 892, y: 235)]

let thirdPointList : [CGPoint] = [CGPoint(x: 158, y: 130), CGPoint(x: 217, y: 135),
                                  CGPoint(x: 283, y: 136), CGPoint(x: 345, y: 144), CGPoint(x: 402, y: 148), CGPoint(x: 472, y: 158),
                                  CGPoint(x: 540, y: 162), CGPoint(x: 593, y: 170), CGPoint(x: 650, y: 180), CGPoint(x: 714, y: 195),
                                  CGPoint(x: 771, y: 206), CGPoint(x: 824, y: 220), CGPoint(x: 882, y: 235)]

let fourthPointList : [CGPoint] = [CGPoint(x: 125, y: 131), CGPoint(x: 170, y: 141), CGPoint(x: 218, y: 139),
                                   CGPoint(x: 269, y: 143), CGPoint(x: 318, y: 146), CGPoint(x: 366, y: 153), CGPoint(x: 410, y: 157),
                                   CGPoint(x: 453, y: 164), CGPoint(x: 502, y: 171), CGPoint(x: 542, y: 177), CGPoint(x: 587, y: 182),
                                   CGPoint(x: 630, y: 193), CGPoint(x: 683, y: 197), CGPoint(x: 727, y: 210), CGPoint(x: 780, y: 219),
                                   CGPoint(x: 833, y: 236), CGPoint(x: 888, y: 244)]

let pointListsForLevels : [[CGPoint]] = [firstPointList, secondPointList, thirdPointList, fourthPointList]
