//
//  model.swift
//  DarkSheep
//
//  Created by Serg MacOs on 25.03.2022.
//

import Foundation
import RealmSwift

class ModelOfPlayer:Object {
    
    @Persisted  var addPlayerRealm:String?
    
    
    convenience init (addPlayerRealm:String?) {
        self.init()
        self.addPlayerRealm = addPlayerRealm
       
        
}

}
