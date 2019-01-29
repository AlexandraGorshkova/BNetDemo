//
//  DataCell.swift
//  BNetDemo
//
//  Created by Alexandra Gorshkova on 27/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit

class DataCell: UITableViewCell {

    @IBOutlet weak var da: UILabel!
    @IBOutlet weak var dm: UILabel!
  
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
