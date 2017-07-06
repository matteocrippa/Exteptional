//
//  Date.swift
//  Exteptional
//
//  Created by Matteo Crippa on 05/07/2017.
//

import Foundation

extension Date {
  public func toString(dateFormat format: String ) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }

}
