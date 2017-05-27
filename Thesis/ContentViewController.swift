//
//  ContentViewController.swift
//  Thesis
//
//  Created by Kaya Thomas on 10/2/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var imgName : String!
    
    var currentGame: String!
    var userid: String!

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = UIImage(named: imgName)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "backToGameSegue"){
            let sceneController : SceneViewController = segue.destination as! SceneViewController
            sceneController.gameSelected = currentGame
            sceneController.userid = userid
        }
    }
 

}
