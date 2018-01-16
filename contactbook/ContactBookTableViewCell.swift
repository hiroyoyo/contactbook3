//
//  ContactBookTableViewCell.swift
//  contactbook
//
//  Created by ryota on 2017/12/22.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class ContactBookTableViewCell: UITableViewCell {
    @IBOutlet weak var Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
