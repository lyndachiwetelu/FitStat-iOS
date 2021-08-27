//
//  ShowStatsViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 27.08.21.
//

import UIKit

class ShowStatsViewController: UIViewController {

    @IBOutlet var statsLabel: UILabel!
    
    var statsText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsLabel.text = statsText
    }


}
