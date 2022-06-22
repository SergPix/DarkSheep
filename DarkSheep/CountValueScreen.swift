//
//  CountValue.swift
//  DarkSheep
//
//  Created by Serg MacOs on 24.03.2022.
//

import UIKit
import RealmSwift

class CountValueScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfCountValue:Results<ModelOfValue>!
    var arrayOfCountPlayer:Results<ModelOfPlayer>!
    var temporaryValue:Results<ModelOfValue>!
    let limitLength = 3
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var saveDataButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardObsorver()
        tableViewOutlet.keyboardDismissMode = .onDrag
        saveDataButtonOutlet.isEnabled = false
        loadAndSaveData()
      
    }
    
    func loadAndSaveData () {
        // load realm dataBase
        arrayOfCountValue = localrealm.objects(ModelOfValue.self)
        arrayOfCountPlayer = localrealm.objects(ModelOfPlayer.self)
        temporaryValue = localrealm.objects(ModelOfValue.self)
        // reset temporary value
        try! localrealm.write{
            for i in arrayOfCountValue {
                i.temporaryValue = 0
            }
        }
    }
    

// MARK: Work with cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfCountPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCellForCountScreen
        
        cell.textLabel?.font = UIFont(name: "Arial", size: 21)
        cell.textLabel?.text = arrayOfCountPlayer[indexPath.row].addPlayerRealm
        cell.textFieldForValue.font = UIFont(name: "Arial", size: 21)
        cell.textFieldForValue.tag = indexPath.row
        cell.textFieldForValue.placeholder = "0"
        cell.textFieldForValue.addTarget(self, action: #selector(cahngeText), for: UIControl.Event.editingChanged)
       
        
        return cell
    }
    
    func addValueToBase (indexOfValue:Int, enterValue:Int) {
        
        for (index,value) in temporaryValue.enumerated() {
            if index == indexOfValue {
                value.temporaryValue = enterValue
            }
        }
    }
    
    
    @objc func cahngeText(sender:UITextField) {
        
        sender.delegate = self
        
        if sender.text?.isEmpty == false {
            saveDataButtonOutlet.isEnabled = true
        } else {
            saveDataButtonOutlet.isEnabled = false
        }
        
        guard let textToInt = Int(sender.text!) else {return}
        
        try! localrealm.write {
            switch sender.tag {
            case 0 : addValueToBase(indexOfValue: 0, enterValue: textToInt)
            case 1 : addValueToBase(indexOfValue: 1, enterValue: textToInt)
            case 2 : addValueToBase(indexOfValue: 2, enterValue: textToInt)
            case 3 : addValueToBase(indexOfValue: 3, enterValue: textToInt)
            case 4 : addValueToBase(indexOfValue: 4, enterValue: textToInt)
            case 5 : addValueToBase(indexOfValue: 5, enterValue: textToInt)
            default: break
                
            }
        }
    }
    
    
    
    // MARK: Methods
    
    // hide keyboard for tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    // this 3 methods do space between keyboard and textFields
    
    func keyboardObsorver () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow () {
        
        let viewSize = view.bounds.height
        
        if  arrayOfCountPlayer.count == 6 && viewSize < 668.0 { // for small Iphone and 6 player
            tableViewOutlet.contentOffset = CGPoint(x: 0, y: 15) // move tabelView
        }
    }
    
    @objc func keyboardWillHide () {
        
        tableViewOutlet.contentOffset = .zero
        
    }
    
    
    // MARK: Buttons
    
    
    @IBAction func saveDataButton(_ sender: UIButton) {
        
        // add value to main screen
        if arrayOfCountValue.isEmpty == true {
            try! localrealm.write{
                for i in arrayOfCountValue {
                    i.addValuerealm = i.temporaryValue
                    i.totalRoundValueRealm = 1
                }
            }
            // sum all value to main screen
        } else {
            try! localrealm.write{
                for i in arrayOfCountValue {
                    i.addValuerealm += i.temporaryValue
                    i.totalRoundValueRealm += 1
                }
            }
        }
    }
    
    
}

// MARK: - extension

extension CountValueScreen:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // add lilit to 3 character
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= limitLength
    }
    }
    

