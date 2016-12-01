//
//  DPTagsViewModel.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import Foundation

class DPTagsViewModel {
    
    var sectionTitle: String?
    var tagModels: [DPTagModel]?
    
    init() {
        
    }
    
    init(sectionTitle: String, tagModels: [DPTagModel]) {
        self.sectionTitle = sectionTitle
        self.tagModels = tagModels
    }
    
}
