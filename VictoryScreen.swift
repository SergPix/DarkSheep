//
//  VictoryScreen.swift
//  
//
//  Created by Serg MacOs on 28.03.2022.
//

import UIKit
import RealmSwift

class VictoryScreen: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var arrayOfCountValue:Results<ModelOfValue>!
    var arrayOfCountPlayer:Results<ModelOfPlayer>!
    var victoryName:String?
    
    @IBOutlet weak var victoryNameLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        arrayOfCountValue = localrealm.objects(ModelOfValue.self)
        arrayOfCountPlayer = localrealm.objects(ModelOfPlayer.self)
        animateVictoryName()
    }
    
    func animateVictoryName () {
        victoryNameLabel.text = victoryName!
        victoryNameLabel.alpha = 0
        
        UIView.animate(withDuration: 2.0) {
            self.victoryNameLabel.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfCountPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Victory") as! CustomCellForVictoryScreen
        
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


