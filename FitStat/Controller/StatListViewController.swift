//
//  StatListViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class StatListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var cellReuseIdentifier : String {
        "StatListTableViewCell"
    }
    
    let categories =  [
        ["Food Stats", #imageLiteral(resourceName: "chart1"), ],
        ["Sleep Stats", #imageLiteral(resourceName: "chart2"),],
        ["Weight Stats", #imageLiteral(resourceName: "chart1"),],
        ["Workout Stats", #imageLiteral(resourceName: "chart2"), ],
        ["Mood Stats", #imageLiteral(resourceName: "chart1"),],
        ["Body Metrics Stats",#imageLiteral(resourceName: "chart2"),],
    ]
    
    var selectedText = ""
    
    var nextSegue: String {
        "goToShowStats"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StatListTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
}


extension StatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedText = categories[indexPath.row][0] as! String
        performSegue(withIdentifier: nextSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nextSegue {
            let destination = segue.destination as! ShowStatsViewController
            destination.navigationItem.title = selectedText
            destination.statsText = "Your \(selectedText) will appear here soon!"
        }
       
    }
}


extension StatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! StatListTableViewCell
        cell.statLabel?.text = categories[indexPath.row][0] as? String
        cell.statChartImage?.image = categories[indexPath.row][1] as? UIImage
        return cell
    }
    
    
}
