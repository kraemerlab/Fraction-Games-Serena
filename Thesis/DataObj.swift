//
//  DataObj.swift
//  Thesis
//
//  Created by Kaya Thomas on 2/27/17.
//  Copyright © 2017 Kaya Thomas. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DataObj {
    let key: String
    let game: String
    let ref: FIRDatabaseReference?
    var info: String
    
    init(info: String, game: String, key: String = "") {
        self.key = key
        self.game = game
        self.info = info
        self.ref = nil
}
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        game = snapshotValue["game"] as! String
        info = snapshotValue["info"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "game": game,
            "info": info
        ]
    }
}
