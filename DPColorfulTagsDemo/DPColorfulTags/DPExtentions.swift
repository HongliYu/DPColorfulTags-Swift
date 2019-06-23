//
//  DPExtentions.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 13/12/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

public extension UIColor {
    
    class func hexStringToUIColor (_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in:
            NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        if (cString.count) != 6 {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

public extension UIViewController {
    
    func alert(_ title: String, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = "Dismiss"
        alertController.addAction(UIAlertAction(title: dismiss,
                                                style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

public extension String {
    
    static func random(_ length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
}

public extension Int {
    
    static func random(from: UInt32, to: UInt32) -> Int {
        return Int(from + arc4random_uniform(to - from))
    }
    
}
