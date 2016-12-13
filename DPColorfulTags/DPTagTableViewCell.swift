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
    fileprivate var tagsViewModel: DPTagsViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(_ tagsViewModel: DPTagsViewModel) {
        self.tagsViewModel = tagsViewModel
        if tagsViewModel.tagModels == nil { return }
        self.label.setTagModels(tagsViewModel.tagModels!)
    }
    
}
