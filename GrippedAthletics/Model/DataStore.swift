//
//  DataStore.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import CoreData

public final class DataStore: NSObject {
    
    static let modelName = "GrippedAthletics"
    
    static let instance : DataStore = DataStore()
    
    private var container : NSPersistentContainer = NSPersistentContainer(name: DataStore.modelName)
    
    func setupStack(withId: String) {
        
    }
}
