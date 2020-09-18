//
//  Extensions.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 2020/9/18.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

extension UITableView {

  func registerCell(_ cellTypes: [AnyClass]) {
    for cellType in cellTypes {
      let typeString = String(describing: cellType)
      let xibPath = Bundle(for: cellType).path(forResource: typeString, ofType: "nib")
      if xibPath == nil {
        self.register(cellType, forCellReuseIdentifier: typeString)
      } else {
        self.register(UINib(nibName: typeString, bundle: nil), forCellReuseIdentifier: typeString)
      }
    }
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

  func times(block: () -> ()) {
    if self > 0 {
      for _ in 0..<self {
        block()
      }
    }
  }

  func times(block: @autoclosure () -> ()) {
    if self > 0 {
      for _ in 0..<self {
        block()
      }
    }
  }

}
