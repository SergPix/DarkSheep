//
//  ViewController.swift
//  
//
//  Created by Serg MacOs on 12.04.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var totalPlayer:Results<ModelOfPlayer>?

    @IBOutlet weak var tabelView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalPlayer = localrealm.objects(ModelOfPlayer.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabelView.delegate = self
        tabelView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalPlayer!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tabelView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = totalPlayer![indexPath.row].addPlayerRealm
        
        return cell!
    }

}
