//
//  DPTagsViewModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

public class DPTagsViewModel {

  var languageEnglishName: String = "English"
  var tagViewModels: [DPTagViewModel]?

  public init(tagViewModels: [DPTagViewModel],
              languageEnglishName: String = "English") {
    self.tagViewModels = tagViewModels
    self.languageEnglishName = languageEnglishName
  }

}

extension DPTagsViewModel: Equatable {

  public static func == (lhs: DPTagsViewModel, rhs: DPTagsViewModel) -> Bool {
    return lhs.tagViewModels == rhs.tagViewModels
  }

}
