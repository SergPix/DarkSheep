//
//  EmptyModel.swift
//  Pods
//
//  Created by Serg MacOs on 21.04.2022.
//

import Foundation
import RealmSwift

class EmptyValue:Object {
    
    @Persisted  var addValuerealm:Int
  
    convenience init (addValuerealm:Int) {
        self.init()
        self.addValuerealm = addValuerealm
    }
        
}

