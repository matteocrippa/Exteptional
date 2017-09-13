//
//  Int.swift
//  Pods
//
//  Created by Matteo Crippa on 29/07/2017.
//
//

import Foundation

extension Int {
  /// Convert Int of seconds since 1970 to Date
  public func dateFromSeconds() -> Date {
    return Date(timeIntervalSince1970: TimeInterval(self))
  }
}
