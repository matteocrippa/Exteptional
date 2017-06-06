//
//  UIImage.swift
//  Pods
//
//  Created by Matteo Crippa on 06/06/2017.
//
//

import UIKit

extension UIImage {
  /// Return an image of a color for a size of
  public func colored(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
