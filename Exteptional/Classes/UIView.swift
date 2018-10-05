//
//  UIView.swift
//  Pods
//
//  Created by Matteo Crippa on 06/06/2017.
//
//

import UIKit
import QuartzCore

@IBDesignable extension UIView {
  @IBInspectable open var borderColor: UIColor? {
    set {
      layer.borderColor = newValue!.cgColor
    }
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor:color)
      } else {
        return nil
      }
    }
  }
  @IBInspectable open var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  @IBInspectable open var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
      clipsToBounds = newValue > 0
    }
    get {
      return layer.cornerRadius
    }
  }

  /// The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
  @IBInspectable open var shadowColor: UIColor? {
    get {
      return UIColor(cgColor: self.layer.shadowColor!)
    }
    set {
      self.layer.shadowColor = newValue?.cgColor
    }
  }

  /// The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
  @IBInspectable open var shadowOpacity: Float {
    get {
      return self.layer.shadowOpacity
    }
    set {
      self.layer.shadowOpacity = newValue
    }
  }

  /// The shadow offset. Defaults to (0, -3). Animatable.
  @IBInspectable open var shadowOffset: CGSize {
    get {
      return self.layer.shadowOffset
    }
    set {
      self.layer.shadowOffset = newValue
    }
  }

  /// The blur radius used to create the shadow. Defaults to 3. Animatable.
  @IBInspectable open var shadowRadius: Double {
    get {
      return Double(self.layer.shadowRadius)
    }
    set {
      self.layer.shadowRadius = CGFloat(newValue)
    }
  }
}

// MARK: Dots & Shadows
extension UIView {
  /// Add a dashed border around the view
  ///
  /// - Parameter color: color of the dashes
  public func addDashedBorder(color: UIColor) {
    let color = color.cgColor

    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6, 3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath

    self.layer.addSublayer(shapeLayer)
  }

  /// Remove any shadow to view
  public func removeShadow() {
    self.layer.shadowColor = UIColor.clear.cgColor
    self.layer.shadowOpacity = 0
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 0.0
  }

}

// MARK: Subviews handler
extension UIView {
  /// Quick way to remove all subviews of current view
  public func removeAllSubViews() {
    _ = self.subviews.map {
      $0.removeFromSuperview()
    }
  }
}

// MARK: Rounded corners
extension UIView {

  /// Make an UIView semi transparent with rounded corners
  ///
  /// - Parameters:
  ///   - corners: what corners are needed to be rounded (refer to UIRectCorner values)
  ///   - backgroundColor: the background color
  ///   - radius: amount of rounded corner
  public func makeTransparentAndRounded(_ corners: UIRectCorner = .allCorners, backgroundColor: UIColor = .white, radius: CGFloat = 6) {
    self.backgroundColor = backgroundColor
    round(corners: corners, radius: radius)
  }

  /// Round the corners with a specified radius
  ///
  /// - Parameters:
  ///   - corners: what corners are needed to be rounded (refer to UIRectCorner values)
  ///   - radius: radius of rounding
  public func round(corners: UIRectCorner, radius: CGFloat) {
    _round(corners: corners, radius: radius)
  }

  /// Round the corners with a border
  ///
  /// - Parameters:
  ///   - corners: what corners are needed to be rounded (refer to UIRectCorner values)
  ///   - radius: radius of rounding
  ///   - borderColor: border color
  ///   - borderWidth: border width
  public func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
    let mask = _round(corners: corners, radius: radius)
    addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
  }

  ///    Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
  ///
  /// - Parameters:
  ///   - width: witdh to be rounded
  ///   - borderColor: set border color
  ///   - borderWidth: set border width
  public func fullyRound(width: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
    layer.masksToBounds = true
    layer.cornerRadius = width / 2
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
  }
}

private extension UIView {

  @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 1, width: bounds.width, height: bounds.height-2), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
    return mask
  }

  func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
    let borderLayer = CAShapeLayer()
    borderLayer.path = mask.path
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = borderWidth
    borderLayer.frame = bounds
    layer.addSublayer(borderLayer)
  }

}
