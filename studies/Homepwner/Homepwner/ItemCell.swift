//
//  ItemCell.swift
//  Homepwner
//
//  Created by Varis Darasirikul on 4/8/2559 BE.
//  Copyright © 2559 BigNerdRangh. All rights reserved.
//

import UIKit

class ItemcCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels(){
        
        //a
        
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumberLabel.font = caption1Font
        
    }
    
}
