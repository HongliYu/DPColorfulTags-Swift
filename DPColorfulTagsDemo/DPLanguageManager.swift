//
//  DPLanguageManager.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 12/11/2017.
//  Copyright © 2017 Hongli Yu. All rights reserved.
//

import Foundation

final class DPLanguageManager {
  
  static let shared = DPLanguageManager()
  private let kCurrentLanguageKey = "AppleLanguages"
  private var currentBundle = Bundle.main
  private(set) var currentLanguage: DPAppLanguage
  
  private func setCurrentLanguage(_ language: DPAppLanguage) {
    currentLanguage = language
    setLanguageInApp(currentLanguage.code)
    NotificationCenter.default.post(name: DPNotification.languageDidChange, object: nil)
  }
  
  public func setCurrentLanguage(_ englishName: String) {
    for language in languages where language.englishName == englishName  {
      setCurrentLanguage(language)
    }
  }
  
  var languages: [DPAppLanguage] {
    get {
      var array = [DPAppLanguage]()
      let codes = Bundle.main.localizations
      for code in codes {
        let language = DPAppLanguage(code: code)
        array.append(language)
      }
      return array
    }
  }
  
  init() {
    if let currentLanguageCodes = UserDefaults.standard.object(forKey: kCurrentLanguageKey) as? [String],
       let currentLanguageCode = currentLanguageCodes.first {
      currentLanguage = DPAppLanguage(code: currentLanguageCode)
      return
    }
    currentLanguage = DPAppLanguage(code: "en")
  }
  
  public func resetDefaultEnglish() {
    setCurrentLanguage(DPAppLanguage(code: "en"))
  }
  
  public func localize(_ inputString: String) -> String {
    return currentBundle.localizedString(forKey: inputString, value: inputString, table: nil)
  }
  
  private func setLanguageInApp(_ code: String) {
    UserDefaults.standard.set([code], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
    guard let bundlePath = Bundle.main.path(forResource: code, ofType: "lproj"),
          let bundle =  Bundle(path: bundlePath) else { return }
    currentBundle = bundle
  }
  
}

struct DPNotification {
  static let languageDidChange = NSNotification.Name(rawValue: "languageDidChange")
}
