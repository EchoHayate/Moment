//
//  AppDelegateExtenstion.swift
//  moment
//
//  Created by Allen Wu on 02/04/2024.
//

import Foundation
import CoreGraphics
import UIKit


@objc
protocol NotificationActionDelegate {
    @objc func noticationAction(_ notification: NSNotification) -> Void
}


protocol NotificationNameDelegate {
    var customName: NSNotification.Name{get}
}

