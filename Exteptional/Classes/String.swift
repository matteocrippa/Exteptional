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
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Return current string localized with extra parameters
    public func localize(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
}

// MARK: - MD5
extension String {
    /*public var md5: String {
     
     let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
     var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
     CC_MD5_Init(context)
     CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
     CC_MD5_Final(&digest, context)
     context.deallocate(capacity: 1)
     var hexString = ""
     for byte in digest {
     hexString += String(format:"%02x", byte)
     }
     
     return hexString
     }*/
}

// MARK: - Random
extension String {
    
    public static func random(length: Int = 20) -> String {
        let base = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()-_=+"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

// MARK: - Validation 
extension String {
    /// Check if is a numeric only string
    public var isNumeric: Bool {
        return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    // Check if is a valid email
    public var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    /// Check if is a valid phone number
    public var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    /// Check if contains a valid url
    public var isUrl: Bool {
        return URL(string: self) != nil
    }
    
}

// MARK: - Manipulation
extension String {
    /// Return omiss if empty string
    public var omiss: String {
        if self.count == 0 {
            return "--"
        } else {
            return self
        }
    }
    
    /// Return a truncated string according supplied params
    public func truncated(toMaxLength length: Int, trailing: String? = "...") -> String {
        if self.count > length {
            let trailingText = trailing ?? ""
            let uptoIndex = length - 1 - trailingText.count
            return String(self[..<self.index(self.startIndex, offsetBy: uptoIndex)]) + trailingText
        } else {
            return self
        }
    }
    
    // Return a monogram according string structure (used in CareKit)
    public var monogram: String {
        
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
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    /// Return a string from html
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}

// MARK: - Conversion
extension String {
    
    /// Return an int
    public var int: Int? {
        return Int(self)
    }
    
    /// Return url
    public var url: URL? {
        return URL(string: self)
    }
    
    /// Return an UIColor according the hexColor provided as string
    public var uiColor: UIColor? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if self.hasPrefix("#") {
            let index   = self.index(self.startIndex, offsetBy: 1)
            let hex     = String(self[index...endIndex])
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
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
fileprivate extension String {
    // MARK: - Monogram generator
    subscript (i: Int) -> String {
        return String(self[self.startIndex..<self.index(self.startIndex, offsetBy: i + 1)])
    }
    
    subscript (r: Range<Int>) -> String {
        get {
            return String(self[self.index(self.startIndex, offsetBy: r.lowerBound)..<self.index(self.startIndex, offsetBy: r.upperBound)])
        }
    }
}
