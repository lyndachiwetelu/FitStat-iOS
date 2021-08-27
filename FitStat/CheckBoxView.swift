//
//  CheckBoxView.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 26.08.21.
//

import UIKit

class CheckBoxView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var checkBoxLabel: UILabel!

    @IBOutlet var checkBoxBtnImg: UIButton!
    
    var delegate: CheckBoxViewDelegate?
    
    var imageState = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func checkBoxClicked(_ sender: UIButton) {
        imageState.toggle()
        updateImage()
        self.delegate?.checkBoxWasClicked(self, with: imageState)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
            initSubviews()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            initSubviews()
        }

        func initSubviews() {
            let nib = UINib(nibName: "CheckBoxView", bundle: nil)
            nib.instantiate(withOwner: self, options: nil)
            contentView.frame = bounds
            addSubview(contentView)
          
        }
    
    func change(to value: Bool) {
        imageState = value
        updateImage()
    }
    
    func updateImage() {
        if imageState == false {
            checkBoxBtnImg.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        } else {
            checkBoxBtnImg.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
    }

}


protocol CheckBoxViewDelegate {
    func checkBoxWasClicked(_ checkbox: CheckBoxView, with value: Bool)
}
