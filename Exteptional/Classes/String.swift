//
//  UIView.swift
//  Pods
//
//  Created by Matteo Crippa on 06/06/2017.
//
//

import Foundation

// MARK: - Localization
extension String {
  /// Return current string localized
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  /// Return current string localized with extra parameters
  func localize(with arguments: CVarArg...) -> String {
    return String(format: self.localized, arguments: arguments)
  }

}

// MARK: - Validation 
extension String {
  /// Check if is a numeric only string
  var isNumeric: Bool {
    return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
  
  // Check if is a valid email
  var isEmail: Bool {
    do {
      let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
      return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
    } catch {
      return false
    }
  }
  
  /// Check if is a valid phone number
  var isPhoneNumber: Bool {
    do {
      let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
      let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
      if let res = matches.first {
        return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.characters.count
      } else {
        return false
      }
    } catch {
      return false
    }
  }

  /// Check if contains a valid url
  var isUrl: Bool {
    return URL(string: self) != nil
  }

}

// MARK: - Manipulation
extension String {
  /// Return omiss if empty string
  var omiss: String {
    if self.characters.count == 0 {
      return "--"
    } else {
      return self
    }
  }
  
  /// Return a truncated string according supplied params
  func truncated(toMaxLength length: Int, trailing: String? = "...") -> String {
    if self.characters.count > length {
      let trailingText = trailing ?? ""
      let uptoIndex = length - 1 - trailingText.characters.count
      return self.substring(to: self.index(self.startIndex, offsetBy: uptoIndex)) + trailingText
    } else {
      return self
    }
  }
  
  // Return a monogram according string structure (used in CareKit)
  var monogram: String {
    
    var monogram = ""
    let words = self.components(separatedBy: " ")
    
    if words.count > 0 {
      monogram = words[0][0]
    }
    if words.count > 1 {
      monogram = "\(monogram)\(words[words.count-1][0])"
    }
    return monogram.uppercased()
  }
  
  
  /// Return an attributed string from html
  var html2AttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
      return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch let error as NSError {
      print(error.localizedDescription)
      return  nil
    }
  }
  
  /// Return a string from html
  var html2String: String {
    return html2AttributedString?.string ?? ""
  }
  
}

// MARK: - Conversion
extension String {
  
  /// Return an int
  var int: Int? {
    return Int(self)
  }
  
  /// Return url
  var url: URL? {
    return URL(string: self)
  }
  
  /// Return an UIColor according the hexColor provided as string
  var uiColor: UIColor? {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    
    if self.hasPrefix("#") {
      let index   = self.characters.index(self.startIndex, offsetBy: 1)
      let hex     = self.substring(from: index)
      let scanner = Scanner(string: hex)
      var hexValue: CUnsignedLongLong = 0
      if scanner.scanHexInt64(&hexValue) {
        switch (hex.characters.count) {
        case 3:
          red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
          green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
          blue  = CGFloat(hexValue & 0x00F)              / 15.0
        case 4:
          red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
          green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
          blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
          alpha = CGFloat(hexValue & 0x000F)             / 15.0
        case 6:
          red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
          green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
          blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
        case 8:
          red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
          green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
          blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
          alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
        default:
          return nil
        }
      } else {
        return nil
      }
    } else {
      return nil
    }
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// MARK: - Functions
extension String {
  // MARK: - Monogram generator
  subscript (i: Int) -> String {
    return self.substring(with: self.startIndex..<self.characters.index(self.startIndex, offsetBy: i + 1))
  }
  
  subscript (r: Range<Int>) -> String {
    get {
      return self.substring(with: self.characters.index(self.startIndex, offsetBy: r.lowerBound)..<self.characters.index(self.startIndex, offsetBy: r.upperBound))
    }
  }
}
