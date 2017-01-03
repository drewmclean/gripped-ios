//
//  UserGraph.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 1/2/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

struct UserGraph {
    
    // MARK: Internal
    
    internal var userGraph : [String : Any]
    
    // MARK: Properties
    
    var id : String? {
        return userGraph["id"] as? String
    }
    
    var email : String? {
        return userGraph["email"] as? String
    }
    
    var birthday : String? {
        return userGraph["birthday"] as? String
    }
    
    var gender : String? {
        return userGraph["gender"] as? String
    }
    
    var name : String? {
        return userGraph["name"] as? String
    }
    
    var picture : [String:Any]? {
        return userGraph["picture"] as? [String:Any]
    }
    
    var picturePath : String? {
        guard let data = picture?["data"] as? [String:Any] else {
            return nil
        }
        return data["url"] as? String
    }
    
    // MARK: Initializers
    
    init(userGraph : [String:Any]) {
        self.userGraph = userGraph
    }
    
}