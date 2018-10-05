//
//  UIApplication.swift
//  Pods
//
//  Created by Matteo Crippa on 06/06/2017.
//
//

import UIKit

extension UIApplication {
  /// Returns if push notification are enabled
  public static var isPushNotificationEnabled: Bool {
    return UIApplication.shared.isRegisteredForRemoteNotifications
  }
}
