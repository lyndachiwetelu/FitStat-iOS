//
//  AddMoodViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class AddMoodViewController: UIViewController {
    @IBOutlet var joyfulStackView: UIStackView!
    @IBOutlet var indifferentStackView: UIStackView!
    @IBOutlet var happyStackView: UIStackView!
    @IBOutlet var sadStackView: UIStackView!
    @IBOutlet var contentStackView: UIStackView!
    @IBOutlet var depressedStackView: UIStackView!
    
    var views : [UIView?] { [ joyfulStackView, indifferentStackView, happyStackView, sadStackView, contentStackView, depressedStackView ] }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
    }
    
    @IBAction func logMoodPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        let tag = gestureRecognizer.view?.tag
        blinkOpacity(for: gestureRecognizer.view)
        gestureRecognizer.view?.layer.borderWidth = 3
        gestureRecognizer.view?.layer.borderColor = UIColor(named: "AppLightPinkPriority")?.cgColor
        removeHighlightForAll(except: tag!)

    }
    
    func addGestureRecognizers() {
        for view in views {
            view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))
        }
    }
    
    func blinkOpacity(for view: UIView?) {
        view?.alpha = 0.5
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { timer in
            view?.alpha = 1
            timer.invalidate()
        }
    }
    
    func removeHighlightForAll(except tag: Int) {
        for view in views {
            if view?.tag != tag {
                view?.layer.borderWidth = 0
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
