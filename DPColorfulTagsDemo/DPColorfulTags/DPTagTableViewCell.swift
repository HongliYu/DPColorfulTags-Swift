//
//  DPTagTableViewCell.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagTableViewCell : UITableViewCell {
  
  @IBOutlet var tagLabel: UILabel!
  private let templateCell = UITableViewCell()

  private var tagsViewModel: DPTagsViewModel?
  var tapActionCallBack:((_ tagModel: DPTagModel)->Void)?

  override func awakeFromNib() {
    super.awakeFromNib()
    setupGesture()
  }
  
  private func setupGesture() {
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
    tagLabel.addGestureRecognizer(recognizer)
  }

  func bindData(_ tagsViewModel: DPTagsViewModel) {
    self.tagsViewModel = tagsViewModel
    updateUI()
  }
  
  func updateUI() {
    guard let tagsViewModel = tagsViewModel, let tagModels = tagsViewModel.tagModels else { return }
    
    let languageEnglishName = tagsViewModel.languageEnglishName
    
    let mutableString = NSMutableAttributedString()
    templateCell.contentView.subviews.forEach { $0.removeFromSuperview() }
    
    for tagModel in tagModels {
      let templateView = DPTagView.loadFromNib()
      
      // MARK: Persian bug in UILabel attributedText by Apple
      if languageEnglishName == "Persian" {
        templateView.label.text = " " + tagModel.attributedTitle().string + " "
        templateView.label.font = UIFont.boldSystemFont(ofSize: tagModel.fontSize)
      } else {
        templateView.label.attributedText = tagModel.attributedTitle()
      }
      
      templateView.label.backgroundColor = tagModel.selected ? tagModel.heightedColor : tagModel.color
      let size = templateView.systemLayoutSizeFitting(templateView.frame.size,
                                                      withHorizontalFittingPriority: .fittingSizeLevel,
                                                      verticalFittingPriority: .fittingSizeLevel)
      // MARK: Persian bug in UILabel attributedText by Apple
      if languageEnglishName == "Persian" {
        templateView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      } else {
        if #available(iOS 11, *) {
          templateView.frame = CGRect(x: 0, y: 0, width: size.width + 8, height: size.height)
        } else {
          templateView.frame = CGRect(x: 0, y: 0, width: size.width + 20, height: size.height)
        }
      }
      
      templateCell.contentView.addSubview(templateView)
      let image = templateView.image()
      
      let attachment = NSTextAttachment()
      attachment.image = image
      let attrString = NSAttributedString(attachment: attachment)
      mutableString.beginEditing()
      mutableString.append(attrString)
      mutableString.endEditing()
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 5
    mutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle,
                               range: NSRange(location: 0, length: mutableString.length))
    tagLabel.attributedText = mutableString
  }
  
  @objc private func tapAction(_ recognizer: UITapGestureRecognizer) {
    guard let label = recognizer.view as? UILabel,
      var tagModels = tagsViewModel?.tagModels else { return }
    
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
    let indexOfCharacter = manager.characterIndex(for: touchPoint, in: container,
                                                  fractionOfDistanceBetweenInsertionPoints: nil)
    let tagModel = tagModels[indexOfCharacter]
    tagModel.selected = !tagModel.selected
    tagModels[indexOfCharacter] = tagModel
    updateUI()
    tapActionCallBack?(tagModel)
  }
  
}
