//
//  ViewController.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 01/12/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    fileprivate var tagsViewModelArray: Array<DPTagsViewModel> = [DPTagsViewModel]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.randomTagsViewModelArray()
        let nib = UINib(nibName: "DPTagTableViewCell", bundle: nil)
        self.mainTableView.register(nib, forCellReuseIdentifier: "DPTagTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return self.tagsViewModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DPTagTableViewCell",
                                                               for: indexPath) as! DPTagTableViewCell
        let tagsViewModel = self.tagsViewModelArray[indexPath.section]
        cell.bindData(tagsViewModel)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let v = view as! UITableViewHeaderFooterView
        v.textLabel?.textColor = UIColor.darkGray
    }
    
    // MARK: - Random Datasource
    func randomString(_ length: Int) -> String {
        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray : [Character] = Array(charactersString.characters)
        var string = ""
        for _ in 0..<length {
            string.append(charactersArray[Int(arc4random()) % charactersArray.count])
        }
        return string
    }
    
    func randomTagsViewModelArray() { // 10 viewModels
        for i in 1...10 {
            let tagsViewModel: DPTagsViewModel = DPTagsViewModel(sectionTitle: "secton\(i)",
                                                                 tagModels: self.randomTagModels())
            self.tagsViewModelArray.append(tagsViewModel)
        }
    }
    
    func randomTagModels() -> Array<DPTagModel> { // 5 ~ 10 TagModels
        var tagModels: Array<DPTagModel> = [DPTagModel]()
        for _ in 1...Int(arc4random_uniform(10) + 5) {
            tagModels.append(self.randomTagModel())
        }
        return tagModels
    }
    
    func randomTagModel() -> DPTagModel {
        var colorsArray: Array<String> = ["#89D14D", "#4D9CD1", "#9F4DD1",
                                          "#D1AE4D", "#D17B4D", "#D15B4D"]
        let tagModel: DPTagModel = DPTagModel(
            dictionary: ["title" : self.randomString(Int(arc4random_uniform(5) + 10)), // 5 ~ 10 characters
                "color" : colorsArray[Int(arc4random_uniform(5) + 0)],
                "heighted_color" : "#D8BFD8",
                "selected" : "0"])
        return tagModel
    }
    
}

