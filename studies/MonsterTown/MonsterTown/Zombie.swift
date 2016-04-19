//
//  Zombie.swift
//  MonsterTown
//
//  Created by Varis Darasirikul on 4/5/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import Foundation

class Zombie: Monster {
    var walksWithLimp = true
    
    final override func terrorizeTown() {
        town?.changePopulation(-10)
        super.terrorizeTown()
    }
    
    func changeName(name: String, walksWithLimp: Bool) {
        self.name = name
        self.walksWithLimp = walksWithLimp
    }
}
