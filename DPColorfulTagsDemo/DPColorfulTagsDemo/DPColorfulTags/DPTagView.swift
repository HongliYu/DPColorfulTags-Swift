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
        label.textColor = UIColor.whiteColor()
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
    private func setupViews() {
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.label)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-4.0-[label]-4.0-|",
            options: .AlignAllTrailing,
            metrics: nil,
            views:  ["label" : self.label]))
        constraints.append(NSLayoutConstraint(item: self.label,
            attribute: .Height,
            relatedBy: .GreaterThanOrEqual,
            toItem: nil,
            attribute: .Height,
            multiplier: 1,
            constant: 24))
        constraints.append(NSLayoutConstraint(item: self.label,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: 3))
        constraints.append(NSLayoutConstraint(item: self,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.label,
            attribute: .Bottom,
            multiplier: 1,
            constant: 3))
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func image() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.renderInContext(context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
