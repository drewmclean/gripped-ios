//
//  KeyStore.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 12/8/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Locksmith

class KeyStore: NSObject {
    
    static let instance : KeyStore = KeyStore()
    
    static let authServiceName = "com.grippedathletics.Gripped"
    
    struct AccountKeys {
        static let password = "password"
    }
    
    func accountData(forEmail email:String) -> [String:Any]? {
        return Locksmith.loadDataForUserAccount(userAccount: email, inService: KeyStore.authServiceName)
    }
    
    internal func dataToUpdate(forEmail email:String) -> [String:Any] {
        if let accountData = accountData(forEmail: email) {
            return accountData
        } else {
            return [String:Any]()
        }
    }
    
    func password(forEmail email:String) -> String? {
        let data = accountData(forEmail: email)
        return data?[AccountKeys.password] as? String
    }
    
    func savePassword(password: String, forEmail email: String) {
        
        var toUpdate = dataToUpdate(forEmail: email)
        toUpdate[AccountKeys.password] = password
        
        do {
            try Locksmith.updateData(data: toUpdate, forUserAccount: email, inService: KeyStore.authServiceName)
        } catch {
            print("Unable to save password to Locksmith keychain: \(error)")
        }
    }
    
    func forgetPassword(forEmail email:String) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: email, inService: KeyStore.authServiceName)
        } catch {
            print("Unable to delete password from Locksmith: \(error)")
        }
    }
    
}
