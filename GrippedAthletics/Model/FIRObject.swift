//
//  FIRObject.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/26/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseDatabase

protocol FIRObject {
    
    var ref : String { get set }
    var identifier : String { get set }
    
}
