//
//  model.swift
//  DarkSheep
//
//  Created by Serg MacOs on 25.03.2022.
//

import Foundation
import RealmSwift

let localrealm = try! Realm()

class ModelOfValue:Object {
    
    @Persisted  var addValuerealm:Int
    @Persisted  var temporaryValue:Int
    @Persisted  var totalRoundValueRealm:Int
  
    convenience init (addValuerealm:Int) {
        self.init()
        self.addValuerealm = addValuerealm
    }
    
    convenience init (temporaryValue:Int,totalRoundValueRealm:Int) {
        self.init()
        self.temporaryValue = temporaryValue
        self.totalRoundValueRealm = totalRoundValueRealm
    }
    
    
        
}
