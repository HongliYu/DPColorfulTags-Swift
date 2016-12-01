//
//  DPTagModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import Foundation
import UIKit

class DPTagModel {
    
    private(set) var title: String?
    private(set) var heightedColor: UIColor?
    private(set) var color: UIColor?

    var selected: Bool = false
    
    init(dictionary: [String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        let heightedColorHex = dictionary["heightedColor"] as? String ?? ""
        self.heightedColor = self.hexStringToUIColor(heightedColorHex)
        let colorHex = dictionary["color"] as? String ?? ""
        self.color = self.hexStringToUIColor(colorHex)
        if (dictionary["selected"] as? String ?? "") == "1" {
            self.selected = true
        } else {
            self.selected = false
        }
    }
    
    func attributedTitle() -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        paragraphStyle.firstLineHeadIndent = 10
        paragraphStyle.headIndent = 10
        paragraphStyle.tailIndent = 10
        let attributes = [
            NSParagraphStyleAttributeName : paragraphStyle,
            NSFontAttributeName : UIFont.boldSystemFontOfSize(14)
        ]
        return NSAttributedString(string: self.title ?? "",
                                  attributes: attributes)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

