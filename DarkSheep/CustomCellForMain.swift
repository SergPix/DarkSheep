//
//  CustomTableViewCell.swift
//  
//
//  Created by Serg MacOs on 12.04.2022.
//

import UIKit

class CustomCellForMain: UITableViewCell {
    
    
    @IBOutlet weak var totalName: UILabel!
    @IBOutlet weak var totalPlayerValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
