//
//  DPTagLabel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagLabel: UILabel {
  
  var tagModels: [DPTagModel]?
  var tapActionCallBack:((_ tagModel: DPTagModel)->Void)?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.setupGesture()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setup()
    self.setupGesture()
  }
  
  fileprivate func setup() {
    self.numberOfLines = 0
    self.lineBreakMode = .byWordWrapping
    self.textAlignment = .left
    self.backgroundColor = UIColor.white
    self.isUserInteractionEnabled = true
  }
  
  fileprivate func setupGesture() {
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(DPTagLabel.tapAction(_:)))
    self.addGestureRecognizer(recognizer)
  }
  
  @objc fileprivate func tapAction(_ recognizer: UITapGestureRecognizer) {
    guard let label = recognizer.view as? UILabel else { return }
    let container = NSTextContainer(size: label.frame.size)
    container.lineFragmentPadding = 0.0
    container.lineBreakMode = label.lineBreakMode
    container.maximumNumberOfLines = label.numberOfLines
    
    let manager = NSLayoutManager()
    manager.addTextContainer(container)
    
    guard let attributedText = label.attributedText else { return }
    let storage = NSTextStorage(attributedString: attributedText)
    storage.addLayoutManager(manager)
    
    let touchPoint = recognizer.location(in: label)
    let indexOfCharacter = manager.characterIndex(for: touchPoint,
                                                  in: container,
                                                  fractionOfDistanceBetweenInsertionPoints: nil)
    guard var tagModels = self.tagModels else { return }
    let tagModel = tagModels[indexOfCharacter]
    tagModel.selected = !tagModel.selected
    tagModels[indexOfCharacter] = tagModel
    self.setTagModels(tagModels)
    self.tapActionCallBack?(tagModel)
    // TODO: add tap action call back
  }
  
  func setTagModels(_ tagModels: [DPTagModel]) {
    self.tagModels = tagModels
    
    let mutableString = NSMutableAttributedString()
    let cell = UITableViewCell()
    
    for tagModel in tagModels {
      let view = DPTagView()
      view.label.attributedText = tagModel.attributedTitle()
      view.label.backgroundColor = tagModel.selected ? tagModel.heightedColor : tagModel.color
      let size = view.systemLayoutSizeFitting(view.frame.size,
                                              withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel,
                                              verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
      if #available(iOS 11, *) {
        view.frame = CGRect(x: 0, y: 0, width: size.width + 8, height: size.height)
      } else {
        view.frame = CGRect(x: 0, y: 0, width: size.width + 20, height: size.height)
      }

      cell.contentView.addSubview(view)
      
      let image = view.image()
      let attachment = NSTextAttachment()
      attachment.image = image
      
      let attrString = NSAttributedString(attachment: attachment)
      mutableString.beginEditing()
      mutableString.append(attrString)
      mutableString.endEditing()
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 5
    mutableString.addAttribute(NSAttributedStringKey.paragraphStyle,
                               value: paragraphStyle,
                               range: NSRange(location: 0, length: mutableString.length))
    self.attributedText = mutableString
  }
  
}
