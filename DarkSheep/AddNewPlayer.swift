//
//  AddNewPlayer.swift
//  
//
//  Created by Serg MacOs on 08.04.2022.
//

import UIKit
import RealmSwift

class AddNewPlayer: UITableViewController {
    
    var addedPlayer:Results<ModelOfPlayer>?
    var addedValue:Results<ModelOfValue>?
    let limitLength = 12
    
    @IBOutlet weak var continueButtonOutlet: UIButton!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addedPlayer = localrealm.objects(ModelOfPlayer.self)
        addedValue = localrealm.objects(ModelOfValue.self)
        disableAndEnableButton() // that the papamrters dont dissapear for reload app
        self.tableView.delaysContentTouches = false // убрать задержку обработки жеста, тем самым возобновить нормальную работу анимации кнопки 
    }
    
    func disableAndEnableButton () {
        if self.addedPlayer!.count > 1 {
            self.continueButtonOutlet.isEnabled = true
        }
        if self.addedPlayer!.count > 5 {
            self.addButtonOutlet.isEnabled = false
        }
    }

    // MARK: - work with cell

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedPlayer!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell-id", for: indexPath)
        
        cell.textLabel?.font = UIFont(name: "Arial", size: 20)
        cell.textLabel?.text = addedPlayer![indexPath.row].addPlayerRealm
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let deleteObject = addedPlayer![indexPath.row]
        let deleteObject2 = addedValue![indexPath.row]
        
        try! localrealm.write{
            localrealm.delete([deleteObject,deleteObject2])
        }
        
        if self.addedPlayer!.count < 2 {
            self.continueButtonOutlet.isEnabled = false
        }
        if addedPlayer!.count < 6 {
            addButtonOutlet.isEnabled = true
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
             
        
    }
    
    // MARK: - Buttons
    
    @IBAction func addPlayerButton(_ sender: UIButton) {
        
       
            let alert = UIAlertController(title: "Добавить нового игрока", message: "", preferredStyle: UIAlertController.Style.alert)
            let alecrtAction = UIAlertAction(title: "Добавить", style: UIAlertAction.Style.default) { action in
                
                guard let addName = alert.textFields?.first?.text else {return}
               
                let realmTask = ModelOfPlayer(addPlayerRealm: addName)
                let realmTask2 = ModelOfValue(temporaryValue: 0, totalRoundValueRealm: 0)
                
                    try! localrealm.write{
                        localrealm.add([realmTask,realmTask2])
                    }
                        // disable button in storyboard
                     self.disableAndEnableButton()
                        
                        self.tableView.reloadData()
                   
                }
            
            let alertCancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addTextField { textField in
                textField.placeholder = "Имя игрока"
                textField.delegate = self
            }
            
            alert.addAction(alecrtAction)
            alert.addAction(alertCancel)
            present(alert, animated: true, completion: nil)
       
        }
        
    @IBAction func continueButton(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAddToMainScreenSegue" {
            let customText = UIBarButtonItem()
            customText.title = "Назад"
            navigationItem.backBarButtonItem = customText
            
            
        }
    }
    
}

// MARK: - extension

extension AddNewPlayer:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // add lilit to 12 character
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
            return newLength <= limitLength
        }
}
