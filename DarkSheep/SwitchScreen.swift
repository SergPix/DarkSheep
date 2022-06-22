//
//  SwitchScreen.swift
//  
//
//  Created by Serg Kolodny on 19.05.2022.
//

import UIKit

class SwitchScreen: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentationViewedOrNot()
    }
    
    
    func presentationViewedOrNot () {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.bool(forKey: "presentationWasViewed")
        
        if key == false {
        let wayToPresentation = storyboard?.instantiateViewController(withIdentifier: "pageView-id") as! PageView
        present(wayToPresentation, animated: true, completion: nil)
        } else {
        let wayToAddPlayer = storyboard?.instantiateViewController(withIdentifier: "navigationController-id")
        present(wayToAddPlayer!, animated: true)
        }
    }
    
}
