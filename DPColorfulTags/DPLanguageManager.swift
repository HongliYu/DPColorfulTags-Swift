//
//  DPLanguageManager.swift
//  DPColorfulTagsDemo
//
//  Created by Hongli Yu on 12/11/2017.
//  Copyright © 2017 Hongli Yu. All rights reserved.
//

import Foundation

final class DPLanguageManager {
  
  /// singleton
  static let shared = DPLanguageManager()
  
  var bundle = Bundle.main
  
  /// the current used Language
  var current: DPAppLanguage = DPAppLanguage(code: "en", name: "English", icon: "iconLanguage-en", nameEnglish: "English", nameLocal: "English") {
    didSet {
      UserDefaults.standard.set([current.code], forKey: "AppleLanguages")
      guard let bundlePath = Bundle.main.path(forResource: current.code, ofType: "lproj") else { return }
      guard let theBundle =  Bundle(path: bundlePath) else { return }
      bundle = theBundle
      NotificationCenter.default.post(name: Notification.Name(rawValue: "languageDidChange"), object: nil)
    }
  }
  
  var currentLocale: Locale {
    get {
      return Locale(identifier: current.code)
    }
  }
  
  /// A array contains all the supported languages included in our app, computed read only
  var languages: [DPAppLanguage] {
    get {
      var array = [DPAppLanguage]()
      let supportLocalizations = Bundle.main.localizations
      for supportLocalization in supportLocalizations {
        let locale = Locale(identifier: supportLocalization)
        let icon = "iconLanguage-\(supportLocalization)"
        var language = DPAppLanguage(code: supportLocalization, name: "", icon: icon, nameEnglish: "", nameLocal: "")
        if let name = (locale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: supportLocalization) {
          language.name = name
        }
        let localeEnglish = Locale(identifier: "en")
        if let ne = (localeEnglish as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: supportLocalization) {
          language.nameEnglish = ne
        }
        let currentLocale = Locale(identifier: current.code)
        if let nl = (currentLocale as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: supportLocalization) {
          language.nameLocal = nl
        }
        array.append(language)
      }
      return array
    }
  }
  
  init() {
    if let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] {
      var chosenLanguageCode = "en"
      for language in languages {
        var code = ""
        let local = Locale(identifier: language)
        guard let localeLanguage = local.languageCode else { break }
        code = localeLanguage
        if Bundle.main.localizations.contains(localeLanguage) {
          chosenLanguageCode = code
          break
        }
        if let localeScript = local.scriptCode {
          code = localeLanguage + "-" + localeScript
        }
        if Bundle.main.localizations.contains(code) {
          chosenLanguageCode = code
          break
        }
      }
      guard let bundlePath = Bundle.main.path(forResource: chosenLanguageCode, ofType: "lproj") else { return }
      guard let theBundle =  Bundle(path: bundlePath) else { return }
      bundle = theBundle
      let icon = "iconLanguage-\(chosenLanguageCode)"
      current = DPAppLanguage(code: chosenLanguageCode, name: "", icon: icon, nameEnglish: "", nameLocal: "")
      let locale = Locale(identifier: chosenLanguageCode)
      guard let name = locale.localizedString(forIdentifier: chosenLanguageCode) else { return }
      current = DPAppLanguage(code: chosenLanguageCode, name: name, icon: icon, nameEnglish: "", nameLocal: "")
      let localeEnglish = Locale(identifier: "en")
      guard let ne = localeEnglish.localizedString(forIdentifier: chosenLanguageCode) else { return }
      current = DPAppLanguage(code: chosenLanguageCode, name: name, icon: icon, nameEnglish: ne, nameLocal: name)
    }
  }
  
  /// Reset current language to English
  func reset() {
    let english = DPAppLanguage(code: "en", name: "English", icon: "iconLanguage-en", nameEnglish: "English", nameLocal: "English")
    current = english
  }
  
  /// Convinent localize, key＝＝value
  /// - parameter inputString: input string
  /// - returns: localized string
  func localize(_ inputString: String) -> String { // convinent
    return self.bundle.localizedString(forKey: inputString, value: inputString, table: nil)
  }
  
}
