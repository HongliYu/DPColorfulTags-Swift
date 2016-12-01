//
//  DPTagTableViewCell.swift
//  DPColorfulTags
//
//  Created by Hongli Yu on 29/11/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import Foundation
import UIKit

class DPTagTableViewCell : UITableViewCell {
    
    @IBOutlet weak var label: DPTagLabel!
    private var tagsViewModel: DPTagsViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(tagsViewModel: DPTagsViewModel) {
        self.tagsViewModel = tagsViewModel
        if tagsViewModel.tagModels == nil { return }
        self.label.enableSelectMode = false
        self.label.setTagModels(tagsViewModel.tagModels!)
    }
    
}
