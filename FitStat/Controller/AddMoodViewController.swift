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
            selectedMood = Moods.joyful
            case 200:
            selectedMood = Moods.indifferent
            case 300:
            selectedMood = Moods.happy
            case 400:
            selectedMood = Moods.sad
            case 500:
            selectedMood = Moods.content
            case 600:
            selectedMood = Moods.depressed
        default:
            selectedMood = Moods.none
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
