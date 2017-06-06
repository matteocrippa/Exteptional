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
  open func addDashedBorder(color: UIColor) {
    let color = color.cgColor
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = kCALineJoinRound
    shapeLayer.lineDashPattern = [6, 3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 0).cgPath
    
    self.layer.addSublayer(shapeLayer)
  }
  
  open func noShadow() {
    
    self.layer.shadowColor = UIColor.clear.cgColor
    self.layer.shadowOpacity = 0
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 0.0
    
  }
  
}

// MARK: Subviews handler
extension UIView {
  open func removeAllSubViews() {
    _ = self.subviews.map {
      $0.removeFromSuperview()
    }
  }
}
