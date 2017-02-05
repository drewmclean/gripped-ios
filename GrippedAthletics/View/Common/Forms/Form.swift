//
//  File.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

protocol FormFieldProvider {
    var formFields : [String : FormField] { get }
}

protocol FormFieldItem {
    var formField : FormField { get set }
}
