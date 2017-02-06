//
//  UIImage.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/12/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

extension UIImage {
    
    static let menu = UIImage(named: "Menu")!
    static let back = UIImage(named: "Back")!
    static let forward = UIImage(named: "Forward")!
    static let checkmark = UIImage(named: "Checkmark")!
    static let close = UIImage(named: "Close")!
    static let home = UIImage(named: "Home")!
    static let contacts = UIImage(named: "Contacts")!
    static let healthBook = UIImage(named: "Health Book")!
    static let climbing = UIImage(named: "Climbing")!
    static let add = UIImage(named: "Add")
    static let delete = UIImage(named: "Delete")
    
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}
