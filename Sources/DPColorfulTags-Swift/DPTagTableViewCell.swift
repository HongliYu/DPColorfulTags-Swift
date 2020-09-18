//
//  DPTagTableViewCell.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

public class DPTagTableViewCell : UITableViewCell {

  @IBOutlet var tagLabel: UILabel!
  private let templateCell = UITableViewCell()

  private var tagsViewModel: DPTagsViewModel?
  open var tapActionCallBack:((_ tagViewModel: DPTagViewModel)->Void)?

  override public func awakeFromNib() {
    super.awakeFromNib()
    setupGesture()
  }

  private func setupGesture() {
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
    tagLabel.addGestureRecognizer(recognizer)
  }

  public func bindData(_ tagsViewModel: DPTagsViewModel?) {
    if self.tagsViewModel != nil && tagsViewModel == self.tagsViewModel {
      return
    }
    self.tagsViewModel = tagsViewModel
    updateUI()
  }

  func updateUI() {
    guard let tagsViewModel = tagsViewModel, let tagViewModels = tagsViewModel.tagViewModels else { return }

    let languageEnglishName = tagsViewModel.languageEnglishName

    let mutableString = NSMutableAttributedString()
    templateCell.contentView.subviews.forEach { $0.removeFromSuperview() }

    for tagViewModel in tagViewModels {
      let templateView = DPTagView.loadFromNib()
      // MARK: Persian bug in UILabel attributedText by Apple
      if languageEnglishName == "Persian" {
        templateView.label.text = " " + tagViewModel.attributedTitle().string + " "
        templateView.label.font = UIFont.boldSystemFont(ofSize: tagViewModel.fontSize)
      } else {
        templateView.label.attributedText = tagViewModel.attributedTitle()
      }
      templateView.label.backgroundColor =
        tagViewModel.selected ? tagViewModel.heightedColor : tagViewModel.color
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
          var tagViewModels = tagsViewModel?.tagViewModels else { return }

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
    let tagModel = tagViewModels[indexOfCharacter]
    tagModel.selected = !tagModel.selected
    tagViewModels[indexOfCharacter] = tagModel
    updateUI()
    tapActionCallBack?(tagModel)
  }

}
