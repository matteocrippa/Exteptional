//
//  Date.swift
//  Pods
//
//  Created by Matteo Crippa on 29/07/2017.
//
//

import Foundation

extension Date {
  /// Check current date is now or in the future
  var isFuture: Bool {
    return self >= Date()
  }
  
  /// Check current date is in the past
  var isPast: Bool {
    return self < Date()
  }
}
