//
//  ViewController.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 01/12/2016.
//  Copyright © 2016 Hongli Yu. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, ViewInput {
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModels: [DPTagsViewModel]?
  
  var output: ViewOutput!

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    basicUI()
    addNotifications()
    output.viewIsReady()
  }

  func basicUI() {
    tableView.registerCell([DPTagTableViewCell.self])
    tableView.estimatedRowHeight = 88
    tableView.rowHeight = UITableView.automaticDimension
  }

  func addNotifications() {
    NotificationCenter
      .default
      .addObserver(self, selector: #selector(languageDidChange(_:)),
                   name: DPNotification.languageDidChange, object: nil)
  }

  deinit {
    NotificationCenter
      .default
      .removeObserver(self, name: DPNotification.languageDidChange, object: nil)
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

  @objc func languageDidChange(_ notification: Notification) {
    output.reloadData()
  }

  // MARK: ViewOutput
  func display(_ viewModels: [DPTagsViewModel]) {
    self.viewModels = viewModels
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
  }

}

// MARK: - Table view datasource/delegate
extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModels?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DPTagTableViewCell.self),
                                                   for: indexPath) as? DPTagTableViewCell,
          let tagsViewModel = viewModels?[indexPath.row] else {
      return UITableViewCell()
    }
    cell.tapActionCallBack = {
      [weak self] tagViewModel in
      guard let strongSelf = self else { return }
      let retString = "\(tagViewModel.title ?? "error") + selected: \(tagViewModel.selected ? "true" : "fasle")"
      strongSelf.alert(retString)
    }
    cell.bindData(tagsViewModel)
    return cell
  }
  
}
