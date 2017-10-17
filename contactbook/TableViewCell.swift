//
//  TableViewCell.swift
//  contactbook
//
//  Created by ryota on 2017/10/12.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var stampImg: UIImageView!
    @IBOutlet weak var themeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
