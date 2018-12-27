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
  private var tagsViewModels: [DPTagsViewModel] = []
  private let kRandomCellCount = 10
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    basicUI()
    basicData()
    addNotifications()
  }
  
  // MARK: - Actions
  @IBAction func persianAction(_ sender: Any) {
    DPLanguageManager.shared.setCurrentLanguage("Persian")
  }
  
  @IBAction func germanAction(_ sender: Any) {
    DPLanguageManager.shared.setCurrentLanguage("German")
  }
  
  @IBAction func englishAction(_ sender: Any) {
    DPLanguageManager.shared.setCurrentLanguage("English")
  }

  // MARK: - UI
  func basicUI() {
    mainTableView.registerCell([DPTagTableViewCell.self])
  }
  
  func addNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange(_:)), name: NSNotification.Name(rawValue: "languageDidChange"), object: nil)
  }
  
  @objc func languageDidChange(_ notification: Notification) {
    resetData()
    mainTableView.reloadData()
  }
  
  // MARK: - Data
  func basicData() {
    randomData()
  }
  
  func resetData() {
    tagsViewModels.removeAll()
    randomData()
  }
  
  func randomData() {
    // Support multi-language
    let tagsViewModel =
      DPTagsViewModel(tagModels: multilanguageTagModels(),
                      languageEnglishName: DPLanguageManager.shared.currentLanguage.englishName)
    tagsViewModels.append(tagsViewModel)
    
    // 10 Random data
    (1...kRandomCellCount).forEach { _ in
      let tagsViewModel = DPTagsViewModel(tagModels: randomTagModels())
      tagsViewModels.append(tagsViewModel)
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
      tagModels.append(createTagModel(title))
    }
    return tagModels
  }
  
  func randomTagModels() -> [DPTagModel] {
    var tagModels: [DPTagModel] = []
    (1...Int.random(from: 10, to: 15)).forEach { _ in
      tagModels.append(createTagModel())
    }
    return tagModels
  }
  
  func createTagModel(_ title: String = String.random(Int.random(from: 10, to: 15))) -> DPTagModel {
    var colors: [String] = ["#89D14D", "#4D9CD1", "#9F4DD1",
                            "#D1AE4D", "#D17B4D", "#D15B4D"]
    let tagModel: DPTagModel = DPTagModel(
      dictionary: ["title" : title,
                   "color" : colors[Int.random(from: 0, to: 5)],
                   "heighted_color" : "#D8BFD8",
                   "selected" : "0",
                   "font_size" : String(Int.random(from: 10, to: 20))])
    return tagModel
  }
  
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 88
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tagsViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier:
      String(describing: DPTagTableViewCell.self), for: indexPath) as? DPTagTableViewCell,
      indexPath.row < tagsViewModels.count
      else { return UITableViewCell() }
    let tagsViewModel = tagsViewModels[indexPath.row]
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
