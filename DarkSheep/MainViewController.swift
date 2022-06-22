//
//  ViewController.swift
//  DarkSheep
//
//  Created by Serg MacOs on 24.03.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var totalValue:Results<ModelOfValue>?
    var totalPlayer:Results<ModelOfPlayer>!
    var dictionaryForWiner : [Int:String] = [:]
    var dictionaryForDraw : [String:Int] = [:]
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var totalRaundValue: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAndConvertData()
        setExodustheGame()
        animateTabelView()
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    // MARK: Methods
    
    func animateTabelView () {
        
        tableViewOutlet.reloadData()
        
        let cells = tableViewOutlet.visibleCells // access all visible cells
        let tabelViewWidth = tableViewOutlet.bounds.width // where will the cells come from
        var dealy:Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tabelViewWidth, y: 0) // to move objects
            UIView.animate(withDuration: 1.5, delay: dealy * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity // move cell to start pisition
            }, completion: nil)
            dealy += 1
        }
    }
    
    func loadAndConvertData () {
        totalValue = localrealm.objects(ModelOfValue.self) // load realm dataBase
        totalPlayer = localrealm.objects(ModelOfPlayer.self) // load realm dataBase
        totalRaundValue.text = String(totalValue!.last!.totalRoundValueRealm)
    }
    
    func setExodustheGame () {
        
        var allValueInArray:[Int] = []
        var lastDuplicateValue:[Int] = []
        
        // add value in new array
        for i in totalValue! {
            allValueInArray.append(i.addValuerealm)
        }
        
        // find duplicate in array
        let sortToDuplicate = Array(Set(allValueInArray.filter({ int in
            allValueInArray.filter({$0 == int}).count > 1})))
        
        for i in sortToDuplicate {
            lastDuplicateValue.append(i)
        }
        
        guard let sortToMaxValue = allValueInArray.max() else {return}
        guard let sortToMinValue = allValueInArray.min() else {return}
        let sortLastDuplicateValue = lastDuplicateValue.min()
        
        // sequencing
        if sortToMinValue >= 200 {
            createLoser()
        } else if sortToMinValue < sortLastDuplicateValue ?? 0 && sortToMaxValue >= 200 || sortToDuplicate.isEmpty == true && sortToMaxValue >= 200 {
            createWiner()
        } else if sortToDuplicate.isEmpty == false && sortToMaxValue >= 200 {
            createDraw()
            
        }
    }
    
    func createWiner () {
        
        // create dictionary
        for (a,b) in zip(totalValue!, totalPlayer!) {
            dictionaryForWiner[a.addValuerealm] = b.addPlayerRealm
        }
        // count min key and value
        let sortToMinValue = dictionaryForWiner.min {a, b in a.key < b.key }
        
        //create the way
        guard let way = storyboard?.instantiateViewController(withIdentifier: "victoryScreenStoryboard-id") as? VictoryScreen else {return}
        
        // send a data from another view
        way.victoryName = sortToMinValue?.value
        
        // set dict to empty, that dont save the value after win
        let emptyDictionary:[Int:String] = [:]
        dictionaryForWiner = emptyDictionary
        
        present(way, animated: true, completion: nil)
    }
    
    
    func createDraw () {
        
        // create dictionary
        for (a,b) in zip(totalPlayer!, totalValue!) {
            dictionaryForDraw[a.addPlayerRealm!] = b.addValuerealm
        }
        
        //create the way
        guard  let way = storyboard?.instantiateViewController(withIdentifier: "DrawScreenStoryboard-id") as? DrawScreen else {return}
        // sort from min to max
        let sort = dictionaryForDraw.sorted { first, second in
            first.value < second.value
        }
        
        let firstValueInDict = sort.first
        // add names in next screen
        for i in sort {
            if i.value < 200 && firstValueInDict?.value == i.value  {
                way.arraySortedValues.append(i.key)
                
            }
        }
        
        // set dict to empty, that dont save the value after win
        let emptyDictionary:[String:Int] = [:]
        dictionaryForDraw = emptyDictionary
        
        present(way, animated: true, completion: nil)
        
    }
    
    func createLoser () {
        
        // create the way
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoserScreenStoryboard-id") as? LosingScreen else {return}
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: Work with cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalPlayer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCellForMain
        
        cell.totalName.text = totalPlayer[indexPath.row].addPlayerRealm
        cell.totalPlayerValue.text = String(totalValue![indexPath.row].addValuerealm)
        
        return cell
    }
    
    
    // MARK: Buttons and segue data
    
    @IBAction func backToMainScreen (sender:UIStoryboardSegue) {
        // this method for unwind segue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromMainToCountScreenSegue" {
            let customText = UIBarButtonItem()
            customText.title = "Назад"
            navigationItem.backBarButtonItem = customText
        }
    }
    
    
}
