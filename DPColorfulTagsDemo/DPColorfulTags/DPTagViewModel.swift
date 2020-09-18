//
//  DPTagViewModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

public class DPTagViewModel {

  public var title: String?
  private(set) var heightedColor: UIColor?
  private(set) var color: UIColor?
  private(set) var fontSize: CGFloat = 14

  public var selected: Bool = false

  public init(dictionary: [String : Any]) {
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

extension DPTagViewModel: CustomStringConvertible {

  public var description: String {
    return "title: \(self.title ?? ""), selected: \(self.selected)\n"
  }

}

extension DPTagViewModel: Equatable {

  public static func == (lhs: DPTagViewModel, rhs: DPTagViewModel) -> Bool {
    return lhs.title == rhs.title
  }

}

public extension UIColor {

  class func hexStringToUIColor (_ hex: String) -> UIColor {
    var cString: String = hex
      .trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet)
      .uppercased()
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
