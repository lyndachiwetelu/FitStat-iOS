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
    
    @IBOutlet var datePicker: UIDatePicker!
    var views : [UIView?] { [ joyfulStackView, indifferentStackView, happyStackView, sadStackView, contentStackView, depressedStackView ] }
    
    var selectedMood = "None"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizers()
    }
    
    @IBAction func logMoodPressed(_ sender: UIButton) {
        var manager = CoreDataManager.shared
        let mood = manager.getInsertObjectFor(entityNamed: "Mood") as! Mood
        mood.time = datePicker.date
        mood.mood = selectedMood
        manager.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        let tag = gestureRecognizer.view?.tag
        blinkOpacity(for: gestureRecognizer.view)
        gestureRecognizer.view?.layer.borderWidth = 3
        gestureRecognizer.view?.layer.borderColor = UIColor(named: "AppLightPinkPriority")?.cgColor
        removeHighlightForAll(except: tag!)
        setSelectedMood(tag: tag!)

    }
    
    func setSelectedMood(tag: Int) {
        switch tag {
            case 100:
            selectedMood = "Joyful"
            case 200:
            selectedMood = "Indifferent"
            case 300:
            selectedMood = "Happy"
            case 400:
            selectedMood = "Happy"
            case 500:
            selectedMood = "Content"
            case 600:
            selectedMood = "Depressed"
        default:
            selectedMood = "None"
        }
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

}
