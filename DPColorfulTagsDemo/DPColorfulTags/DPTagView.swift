//
//  DPTagView.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagView: UIView {
  
  @IBOutlet var label: UILabel!
  
  func image() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    layer.render(in: context)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return image
  }
  
}
