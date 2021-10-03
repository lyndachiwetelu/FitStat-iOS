//
//  StatListTableViewCell.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit

class StatListTableViewCell: UITableViewCell {

    @IBOutlet var statChartImage: UIImageView!
    @IBOutlet var statLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
