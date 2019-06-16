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

public extension UITableView {
    
    func registerCell(_ cellTypes:[AnyClass]) {
        for cellType in cellTypes {
            let typeString = String(describing: cellType)
            let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: "nib")
            if xibPath == nil {
                register(cellType, forCellReuseIdentifier: typeString)
            } else {
                register(UINib(nibName: typeString, bundle: Bundle.targetBundle),
                         forCellReuseIdentifier: typeString)
            }
        }
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

protocol UIViewLoading {}
extension UIView : UIViewLoading {}

extension UIViewLoading where Self : UIView {
    
    // note that this method returns an instance of type `Self`, rather than UIView
    static func loadFromNib() -> Self {
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: Bundle.targetBundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
}

extension Bundle {
    
    static var targetBundle: Bundle? {
        var retBundle: Bundle?
        let bundle = Bundle(for: self.classForCoder())
        if let url = bundle.url(forResource: "Pod1", withExtension: "bundle") {
            retBundle = Bundle(url: url)
        }
        return retBundle
    }
    
}
