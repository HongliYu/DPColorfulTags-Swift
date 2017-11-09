//
//  DPTagTableViewCell.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

let kDPTagTableViewCellReuseID = "DPTagTableViewCell"

class DPTagTableViewCell : UITableViewCell {
  
  @IBOutlet weak var tagLabel: DPTagLabel!
  fileprivate var tagsViewModel: DPTagsViewModel?
  var tapActionCallBack:((_ tagModel: DPTagModel)->Void)?

  func bindData(_ tagsViewModel: DPTagsViewModel) {
    self.tagsViewModel = tagsViewModel
    guard let tagModels = tagsViewModel.tagModels else { return }
    self.tagLabel.setTagModels(tagModels)
    self.tagLabel.tapActionCallBack = {
      [weak self] tagModel in
      guard let strongSelf = self else { return }
      strongSelf.tapActionCallBack?(tagModel)
    }
  }
  
}
