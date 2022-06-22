//
//  DrawScreen.swift
//  
//
//  Created by Serg MacOs on 01.04.2022.
//

import UIKit
import RealmSwift

class DrawScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrayOfCountValue:Results<ModelOfValue>!
    var arrayOfCountPlayer:Results<ModelOfPlayer>!
    
    @IBOutlet weak var sheepImage: UIImageView!
    @IBOutlet var collectionOfNames: [UILabel]!
    
    var arraySortedValues:[String] = []
    var sortLabel:[UILabel] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeImage()
        arrayOfCountValue = localrealm.objects(ModelOfValue.self)
        arrayOfCountPlayer = localrealm.objects(ModelOfPlayer.self)
        animateDrawName()
        nameInlabel()
    }
    
    func animateDrawName () {
        for name in collectionOfNames {
            name.alpha = 0
        }
        
        UIView.animate(withDuration: 2.0) {
            for name in self.collectionOfNames {
                name.alpha = 1
            }
        }
    }
    
    func nameInlabel () {
        
        for name in collectionOfNames {
            name.alpha = 0
        }
        
        for (currentName,sorteName) in zip(collectionOfNames, arraySortedValues) {
            
            currentName.text = sorteName
            
            if currentName.text?.isEmpty == false {
                currentName.alpha = 1
            }
        }
    }
    
    func changeImage () {
        
        if arraySortedValues.count == 2 {
            sheepImage.image = UIImage(named: "drawSheepFor2Player")
        } else if arraySortedValues.count == 3 {
            sheepImage.image = UIImage(named: "drawSheepFor3Player")
        } else if arraySortedValues.count == 4 {
            sheepImage.image = UIImage(named: "drawSheepFor4Player")
        } else if arraySortedValues.count == 5 {
            sheepImage.image = UIImage(named: "drawSheepFor5Player")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCountPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell-Draw") as! CustomCellFromDrawScreen
        
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
