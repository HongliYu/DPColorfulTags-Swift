//
//  Presenter.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 2020/9/18.
//  Copyright © 2020 Hongli Yu. All rights reserved.
//

import Foundation

final class Presenter: ViewOutput {

  weak var view: ViewInput!
  private let kRandomCellCount = 10

  // MARK: - NewsViewOutput
  func viewIsReady() {
    fetchData()
  }

  func reloadData() {
    fetchData()
  }

  // MARK: Fetch data from interactor
  private func fetchData() {
    view.display(localData())
  }

  // Multi-language model + 10 random model
  private func localData() -> [DPTagsViewModel] {
    var viewModels = [DPTagsViewModel]()
    let viewModel = DPTagsViewModel(tagViewModels: multilanguageTagModels(),
                                    languageEnglishName: DPLanguageManager.shared.currentLanguage.englishName)
    viewModels.append(viewModel)
    kRandomCellCount.times {
      let viewModel = DPTagsViewModel(tagViewModels: randomTagModels())
      viewModels.append(viewModel)
    }
    return viewModels
  }

  private func multilanguageTagModels() -> [DPTagViewModel] {
    var tagViewModels: [DPTagViewModel] = []
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
      tagViewModels.append(createTagModel(title))
    }
    return tagViewModels
  }

  private func randomTagModels() -> [DPTagViewModel] {
    var tagModels: [DPTagViewModel] = []
    (1...Int.random(from: 10, to: 15)).forEach { _ in
      tagModels.append(createTagModel())
    }
    return tagModels
  }

  private func createTagModel(_ title: String = String.random(Int.random(from: 10, to: 15))) -> DPTagViewModel {
    let colors: [String] = ["#89D14D", "#4D9CD1", "#9F4DD1",
                            "#D1AE4D", "#D17B4D", "#D15B4D"]
    let tagViewModel: DPTagViewModel = DPTagViewModel(
      dictionary: ["title" : title,
                   "color" : colors[Int.random(from: 0, to: 5)],
                   "heighted_color" : "#D8BFD8",
                   "selected" : "0",
                   "font_size" : String(Int.random(from: 10, to: 20))])
    return tagViewModel
  }

}

protocol ViewOutput {
  func viewIsReady()
  func reloadData()
}

protocol ViewInput: class {
  func display(_ vewModels: [DPTagsViewModel])
}
