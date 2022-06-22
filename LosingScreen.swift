//
//  LosingScreen.swift
//  
//
//  Created by Serg MacOs on 31.03.2022.
//

import UIKit
import RealmSwift

class LosingScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfCountValue:Results<ModelOfValue>!
    var arrayOfCountPlayer:Results<ModelOfPlayer>!
    
    @IBOutlet weak var allLoseLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arrayOfCountValue = localrealm.objects(ModelOfValue.self)
        arrayOfCountPlayer = localrealm.objects(ModelOfPlayer.self)
        animateLoserName()
    }
    
    func animateLoserName () {
        allLoseLabel.alpha = 0
        
        UIView.animate(withDuration: 2.0) {
            self.allLoseLabel.alpha = 1
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCountPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Loser") as! CustomCellForLoserScreen
        
        cell.nameLabel.text = arrayOfCountPlayer[indexPath.row].addPlayerRealm
        cell.valueLabel.text = String(arrayOfCountValue[indexPath.row].addValuerealm)
        
        return cell
    }
    
    
    @IBAction func endGameAndReturnToMainScreenButton(_ sender: UIButton) {
        // load realm dataBase
        arrayOfCountValue = localrealm.objects(ModelOfValue.self)
        // refresh realm dataBase
        try! localrealm.write{
            
            for i in arrayOfCountValue! {
                i.totalRoundValueRealm = 0
                i.addValuerealm = 0
            }
        }
    }
    
    
    
}
