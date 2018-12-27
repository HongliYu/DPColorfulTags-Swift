//
//  DPTagModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagModel {
  
  private(set) var title: String?
  private(set) var heightedColor: UIColor?
  private(set) var color: UIColor?
  private(set) var fontSize: CGFloat = 14

  var selected: Bool = false
  
  init(dictionary: [String : Any]) {
    self.title = dictionary["title"] as? String ?? ""
    let colorHex = dictionary["color"] as? String ?? ""
    self.color = UIColor.hexStringToUIColor(colorHex)
    self.selected = (dictionary["selected"] as? String ?? "") == "1"
    let heightedColorHex = dictionary["heighted_color"] as? String ?? ""
    self.heightedColor = UIColor.hexStringToUIColor(heightedColorHex)
    let fontSize = dictionary["font_size"] as? String ?? ""
    let size = NumberFormatter().number(from: fontSize) ?? 0
    self.fontSize = CGFloat(truncating: size)
  }
  
  func attributedTitle() -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.firstLineHeadIndent = 10
    paragraphStyle.headIndent = 10
    paragraphStyle.tailIndent = 10
    let attributes = [
      NSAttributedString.Key.paragraphStyle : paragraphStyle,
      NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)
    ]
    return NSAttributedString(string: title ?? "", attributes: attributes)
  }
  
}

extension DPTagModel: CustomStringConvertible {
  
  public var description : String {
    return "title: \(self.title ?? ""), selected: \(self.selected)\n"
  }
  
}

