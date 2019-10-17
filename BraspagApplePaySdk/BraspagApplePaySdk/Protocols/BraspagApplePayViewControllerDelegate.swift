//
//  BraspagViewControllerProtocol.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import UIKit

@objc public protocol BraspagApplePayViewControllerDelegate {
    func displayAlert(title: String, message: String)
    func presentAuthorizationViewController(viewController: UIViewController)
    func dismissPaymentAuthorizationViewController()
}
