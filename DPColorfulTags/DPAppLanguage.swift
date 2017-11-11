//
//  DPAppLanguage.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 12/11/2017.
//  Copyright © 2017 Hongli Yu. All rights reserved.
//

import Foundation

func == (lhs: DPAppLanguage, rhs: DPAppLanguage) -> Bool {
  return lhs.code == rhs.code
}

struct DPAppLanguage: Equatable {
  
  var code = ""
  var name = ""
  var icon = ""
  var nameEnglish = ""
  var nameLocal = ""
  
}
