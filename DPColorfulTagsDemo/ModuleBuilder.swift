//
//  ModuleBuilder.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 2020/9/18.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import UIKit

final class ModuleBuilder {

  func build() -> UIViewController {
    guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else {
      return UIViewController()
    }

    let presenter = Presenter()
    presenter.view = viewController
    viewController.output = presenter

    return viewController
  }

}
