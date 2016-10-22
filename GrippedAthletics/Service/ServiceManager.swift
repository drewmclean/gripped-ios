//
//  ServiceManager.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito

class ServiceManager: NSObject {
    
    private static let identityPoolId = "us-west-2:79e40bf4-dd4e-48aa-8597-65a2b6f9aa72"
    
    static let instance = ServiceManager()
    
    func initalize() {
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .usWest2,
                                                                identityPoolId: ServiceManager.identityPoolId)
        
        let configuration = AWSServiceConfiguration(region: .usWest2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
}
