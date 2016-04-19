//
//  Town.swift
//  MonsterTown
//
//  Created by Varis Darasirikul on 4/5/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import Foundation

struct Town {
    var population = 5422
    var numberOfStoplights = 4
    
    func printTownDescription() {
        print("Population: \(population) number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(amount: Int){
        population += amount
    }
    
}
