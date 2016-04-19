//
//  main.swift
//  MonsterTown
//
//  Created by Varis Darasirikul on 4/5/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import Foundation

var myTown = Town()
//print("Population: \(myTown.population)")
myTown.changePopulation(500)
myTown.printTownDescription()

let gm = Monster()
gm.town = myTown
gm.terrorizeTown()