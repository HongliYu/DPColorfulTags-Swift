# DPColorfulTags-Swift
tags with different colors in UITableview

[![Cocoapods](https://img.shields.io/cocoapods/v/DPColorfulTags.svg)](http://cocoapods.org/?q=DPColorfulTags)
[![Pod License](http://img.shields.io/cocoapods/l/DPColorfulTags.svg)](https://github.com/HongliYu/DPColorfulTags-Swift/blob/master/LICENSE)

<img src="https://github.com/HongliYu/DPColorfulTags-Swift/blob/master/DPColorfulTags.png?raw=true" alt="alt text"  height="400">

# Usage

```  swift

  // 1. data source
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
    for i in 1...10 {
      let tagsViewModel: DPTagsViewModel = DPTagsViewModel(sectionTitle: "secton\(i)",
        tagModels: self.randomTagModels())
      self.tagsViewModels.append(tagsViewModel)
    }
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

  // 2. cell bind data & action
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kDPTagTableViewCellReuseID, for: indexPath) as! DPTagTableViewCell
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

```