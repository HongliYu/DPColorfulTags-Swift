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
  fileprivate var tagsViewModels: [DPTagsViewModel] = []
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.basicUI()
    self.basicData()
    self.addNotifications()
  }
  
  // MARK: - Actions
  @IBAction func PersianAction(_ sender: Any) {
    for language in DPLanguageManager.shared.languages {
      if language.nameEnglish == "Persian" {
        DPLanguageManager.shared.current = language
      }
    }
  }
  
  @IBAction func GermanAction(_ sender: Any) {
    for language in DPLanguageManager.shared.languages {
      if language.nameEnglish == "German" {
        DPLanguageManager.shared.current = language
      }
    }
  }
  
  // MARK: - UI
  func basicUI() {
    let nib = UINib(nibName: kDPTagTableViewCellReuseID, bundle: nil)
    self.mainTableView.register(nib, forCellReuseIdentifier: kDPTagTableViewCellReuseID)
  }
  
  func addNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange(_:)), name: NSNotification.Name(rawValue: "languageDidChange"), object: nil)
  }
  
  @objc func languageDidChange(_ notification: Notification) {
    self.refreshData()
    self.mainTableView.reloadData()
  }
  
  // MARK: - Data
  func basicData() {
    self.randomData()
  }
  
  func refreshData() {
    self.tagsViewModels.removeAll()
    self.randomData()
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
  
  func randomData() { // 10 ViewModels
    // Support multi-language
    let tagsViewModel: DPTagsViewModel = DPTagsViewModel(sectionTitle: "secton multi-language",
                                                         tagModels: self.multilanguageTagModels())
    self.tagsViewModels.append(tagsViewModel)
    
    // Random data
    for i in 1...10 {
      let tagsViewModel: DPTagsViewModel = DPTagsViewModel(sectionTitle: "secton\(i)",
        tagModels: self.randomTagModels())
      self.tagsViewModels.append(tagsViewModel)
    }
  }
  
  func multilanguageTagModels() -> [DPTagModel] {
    var tagModels: [DPTagModel] = []
    let rawStringArray = ["10+ years experience",
                          "freelance", "part-time",
                          "16-68 years old",
                          "industry: broadcasting - radio - tv",
                          "male - female",
                          "master's degree",
                          "urdu", "ant", "all nationalities",
                          "2 vacancies", "closing date 21 Nov, 2017"]
    for element in rawStringArray {
      let title = DPLanguageManager.shared.localize(element)
      tagModels.append(self.multilanguageTagModel(title: title))
    }
    return tagModels
  }
  
  func randomTagModels() -> [DPTagModel] { // 5 ~ 10 TagModels
    var tagModels: [DPTagModel] = []
    for _ in 1...Int(arc4random_uniform(10) + 5) {
      tagModels.append(self.randomTagModel())
    }
    return tagModels
  }
  
  func randomTagModel() -> DPTagModel {
    var colors: [String] = ["#89D14D", "#4D9CD1", "#9F4DD1",
                            "#D1AE4D", "#D17B4D", "#D15B4D"]
    let tagModel: DPTagModel = DPTagModel(
      dictionary: ["title" : self.randomString(Int(arc4random_uniform(5) + 10)), // 5 ~ 10 characters
        "color" : colors[Int(arc4random_uniform(5) + 0)],
        "heighted_color" : "#D8BFD8",
        "selected" : "0"])
    return tagModel
  }
  
  func multilanguageTagModel(title: String) -> DPTagModel {
    var colors: [String] = ["#89D14D", "#4D9CD1", "#9F4DD1",
                            "#D1AE4D", "#D17B4D", "#D15B4D"]
    let tagModel: DPTagModel = DPTagModel(
      dictionary: ["title" : title,
                   "color" : colors[Int(arc4random_uniform(5) + 0)],
                   "heighted_color" : "#D8BFD8",
                   "selected" : "0"])
    return tagModel
  }
  
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let v = view as! UITableViewHeaderFooterView
    v.textLabel?.textColor = UIColor.darkGray
  }
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.tagsViewModels.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kDPTagTableViewCellReuseID,
                                             for: indexPath) as! DPTagTableViewCell
    if indexPath.section >= self.tagsViewModels.count { return cell }
    let tagsViewModel = self.tagsViewModels[indexPath.section]
    cell.tapActionCallBack = {
      [weak self] tagModel in
      guard let strongSelf = self else { return }
      let retString = "\(tagModel.title ?? "error") + selected: \(tagModel.selected ? "true" : "fasle")"
      strongSelf.alert(retString)
    }
    cell.bindData(tagsViewModel)
    return cell
  }
  
}

