//
//  HistoryTableViewCell.swift
//  MovieHistory
//
//  Created by Hironobu Makado on 2017/05/09.
//  Copyright © 2017年 stash4. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var historyDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
