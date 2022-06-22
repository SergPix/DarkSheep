//
//  AddNewPlayerScreen.swift
//  
//
//  Created by Serg MacOs on 03.04.2022.
//

import UIKit
import RealmSwift

class AddNewPlayerScreen: UIViewController {

    var addedPlayer:Results<ModelOfPlayer>?
    let deafultname = "Player One"
    
    @IBOutlet weak var playerOneOutlet: UILabel!
    @IBOutlet weak var playerTwoOutlet: UILabel!
    @IBOutlet weak var playerThreeOutlet: UILabel!
    @IBOutlet weak var clearPlayerOneOutlet: UIButton!
    @IBOutlet weak var clearPlayerTwoOutlet: UIButton!
    @IBOutlet weak var clerarPlayerThreeOutlet: UIButton!
    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.loadView()
            loadAndConvertData()
            displayTheLabel()
            
    }
    
    func displayTheLabel () {
        if playerOneOutlet.text?.isEmpty == true , playerTwoOutlet.text?.isEmpty == true , playerThreeOutlet.text?.isEmpty == true {
            clearPlayerOneOutlet.alpha = 0
            clearPlayerTwoOutlet.alpha = 0
            clerarPlayerThreeOutlet.alpha = 0
        } else if playerTwoOutlet.text?.isEmpty == true , playerThreeOutlet.text?.isEmpty == true {
            clearPlayerTwoOutlet.alpha = 0
            clerarPlayerThreeOutlet.alpha = 0
        } else if playerThreeOutlet.text?.isEmpty == true {
            clerarPlayerThreeOutlet.alpha = 0
        }
    }
    
    func loadAndConvertData () {
        addedPlayer = localrealm.objects(ModelOfPlayer.self)
        
        
        if addedPlayer?.isEmpty == true {
            playerOneOutlet.text = ""
            playerTwoOutlet.text = ""
            playerThreeOutlet.text = ""
        } else {
            
            playerOneOutlet.text = addedPlayer?.first!.addPlayerRealm
            playerTwoOutlet.text = addedPlayer?.last!.playerTwoRealm
            playerThreeOutlet.text = addedPlayer?.last!.playerThreeRealm
           
        }
        
    }
    
    
    @IBAction func addNewPlayer(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Добавить нового игрока", message: "", preferredStyle: UIAlertController.Style.alert)
        let alecrtAction = UIAlertAction(title: "Добавить", style: UIAlertAction.Style.default) { action in
            guard let addName = alert.textFields?.first?.text else {return}
            
            
            if self.playerOneOutlet.text?.isEmpty == true {
                self.playerOneOutlet.text = addName
                self.clearPlayerOneOutlet.alpha = 1
                let realmTask = ModelOfPlayer(playerOneRealm: addName)
                try! localrealm.write{
                   localrealm.add(realmTask)
               }
            } else if self.playerTwoOutlet.text?.isEmpty == true {
                self.playerTwoOutlet.text = addName
                self.clearPlayerTwoOutlet.alpha = 1
                let realmTask2 = ModelOfPlayer(playerTwoRealm: addName)
                try! localrealm.write{
                    localrealm.add(realmTask2)
               }
            } else if self.playerThreeOutlet.text?.isEmpty == true {
                self.playerThreeOutlet.text = addName
                self.clerarPlayerThreeOutlet.alpha = 1
                let realmTask3 = ModelOfPlayer(playerThreeRealm: addName)
                try! localrealm.write{
                    localrealm.add(realmTask3)
               }
            }
               
            }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addTextField { textField in
            textField.placeholder = "Имя игрока"
        }
        
        alert.addAction(alecrtAction)
        alert.addAction(alertCancel)
       
        present(alert, animated: true, completion: nil)
        
       
        
        
    }
    
    
    @IBAction func continueButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func clearAllBase(_ sender: UIButton) {
        try! localrealm.write{
            localrealm.deleteAll()
            }
        
        playerOneOutlet.text = ""
        playerTwoOutlet.text = ""
        playerThreeOutlet.text = ""
        clearPlayerOneOutlet.alpha = 0
        clearPlayerTwoOutlet.alpha = 0
        clerarPlayerThreeOutlet.alpha = 0
    }
    
    @IBAction func clearPlayerOne(_ sender: UIButton) {
       
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAddPlayerToMainSegue" {
            
        }
    }
    
    
    
    }
    

