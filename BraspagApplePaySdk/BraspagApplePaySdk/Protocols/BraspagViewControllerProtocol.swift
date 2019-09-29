//
//  BraspagViewControllerProtocol.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import UIKit

@objc public protocol BraspagViewControllerProtocol {
    func displayAlert(title: String, message: String)
    func presentPayment(viewController: UIViewController)
    func dismissPayment()
}
