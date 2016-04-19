//
//  Monster.swift
//  MonsterTown
//
//  Created by Varis Darasirikul on 4/5/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import Foundation

class Monster {
    var town: Town?
    var name = "Monster"
    
    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town !")
        } else {
            print("\(name) hasn't found a town to terrorize yet ...")
        }
    }
    
}