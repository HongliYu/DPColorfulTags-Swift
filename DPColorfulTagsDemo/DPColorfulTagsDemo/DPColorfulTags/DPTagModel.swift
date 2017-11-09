//
//  DPTagModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagModel {
  
  fileprivate(set) var title: String?
  fileprivate(set) var heightedColor: UIColor?
  fileprivate(set) var color: UIColor?
  var selected: Bool = false
  
  init(dictionary: [String : Any]) {
    self.title = dictionary["title"] as? String ?? ""
    let colorHex = dictionary["color"] as? String ?? ""
    self.color = UIColor.hexStringToUIColor(colorHex)
    self.selected = (dictionary["selected"] as? String ?? "") == "1"
    let heightedColorHex = dictionary["heighted_color"] as? String ?? ""
    self.heightedColor = UIColor.hexStringToUIColor(heightedColorHex)
  }
  
  func attributedTitle() -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.firstLineHeadIndent = 10
    paragraphStyle.headIndent = 10
    paragraphStyle.tailIndent = 10
    let attributes = [
      NSAttributedStringKey.paragraphStyle : paragraphStyle,
      NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)
    ]
    return NSAttributedString(string: self.title ?? "",
                              attributes: attributes)
  }
  
}

// MARK: - CustomStringConvertible
extension DPTagModel: CustomStringConvertible {
  
  public var description : String {
    return "title: \(self.title ?? ""), selected: \(self.selected)\n"
  }
  
}

