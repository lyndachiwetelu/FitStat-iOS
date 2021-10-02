//
//  CheckUserViewController.swift
//  FitStat
//
//  Created by Lynda Chiwetelu on 02.10.21.
//

import UIKit

class CheckUserViewController: UIViewController, UsesUserDefault {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = getUserDefaultValue(for: AppConstant.userDetailsKey)
        guard user == nil else {
            performSegue(withIdentifier: AppConstant.segueToMainView, sender: self)
            return
        }
        
        performSegue(withIdentifier: AppConstant.segueToUserDetailsView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        dest.modalPresentationStyle = .fullScreen
    }

}
