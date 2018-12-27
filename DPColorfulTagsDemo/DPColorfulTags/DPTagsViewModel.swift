//
//  DPTagsViewModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class DPTagsViewModel {
  
  var languageEnglishName: String = "English"
  var tagModels: [DPTagModel]?
  
  init(tagModels: [DPTagModel], languageEnglishName: String = "English") {
    self.tagModels = tagModels
    self.languageEnglishName = languageEnglishName
  }
  
}
