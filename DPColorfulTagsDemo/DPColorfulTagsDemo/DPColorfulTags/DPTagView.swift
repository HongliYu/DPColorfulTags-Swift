//
//  DPTagView.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import Foundation
import UIKit

class DPTagView: UIView {
    
    lazy var label = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    // MARK: Basic UI
    fileprivate func setupViews() {
        self.backgroundColor = UIColor.white
        self.addSubview(self.label)
        self.setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-4.0-[label]-4.0-|",
            options: .alignAllTrailing,
            metrics: nil,
            views:  ["label" : self.label]))
        constraints.append(NSLayoutConstraint(item: self.label,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 24))
        constraints.append(NSLayoutConstraint(item: self.label,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 3))
        constraints.append(NSLayoutConstraint(item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.label,
            attribute: .bottom,
            multiplier: 1,
            constant: 3))
        NSLayoutConstraint.activate(constraints)
    }
    
    func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
