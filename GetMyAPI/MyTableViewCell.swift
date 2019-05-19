//
//  MyTableViewCell.swift
//  GetMyAPI
//
//  Created by Joy on 2019/5/18.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var firstPageName: UILabel!
    @IBOutlet weak var firstPagePrice: UILabel!
    @IBOutlet weak var firstPageImageView: UIImageView!
    
    @IBOutlet weak var firstPageDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
