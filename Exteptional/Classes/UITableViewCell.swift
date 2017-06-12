//
//  UITableViewCell.swift
//  Exteptional
//
//  Created by Matteo Crippa on 11/06/2017.
//

import UIKit

extension UITableViewCell {
  
  /// Enables disclosure to be tintable
  public func tintDisclosure(with color: UIColor) {
    for case let button as UIButton in subviews {
      let image = button.backgroundImage(for: .normal)
      image?.withRenderingMode(.alwaysTemplate)
      button.setBackgroundImage(image, for: .normal)
      button.tintColor = color
    }
  }
}
