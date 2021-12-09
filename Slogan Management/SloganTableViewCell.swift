//
//  SloganTableViewCell.swift
//  Slogan Management
//
//  Created by EbitNHP-i1 on 14/06/18.
//  Copyright © 2018 EbitNHP-i1. All rights reserved.
//

import UIKit

class SloganTableViewCell: UITableViewCell {

    @IBOutlet weak var sloganTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
