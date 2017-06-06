//
//  UISegmentedControl.swift
//  Pods
//
//  Created by Matteo Crippa on 06/06/2017.
//
//

import UIKit

extension UISegmentedControl {
  
  /// Remove borders from a SegmentedControl
  open func removeBorders(backgroundSelected: UIColor = .clear, textColor: UIColor = .clear, height: Int = 1) {
    
    let size = CGSize(width: 1, height: height)
    
    // set aspect
    setDividerImage(UIImage().colored(with: .clear, size: size), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    setBackgroundImage(UIImage().colored(with: .clear, size: size), for: .normal, barMetrics: .default)
    setBackgroundImage(UIImage().colored(with: backgroundSelected, size: size), for: .selected, barMetrics: .default)
    
    let segAttributes: NSDictionary = [
      NSForegroundColorAttributeName: textColor
    ]
    
    // set title attribute for selected
    setTitleTextAttributes(segAttributes as [NSObject : AnyObject], for: .selected)
    
  }
}
