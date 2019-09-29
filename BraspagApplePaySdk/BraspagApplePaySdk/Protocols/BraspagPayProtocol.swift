//
//  BraspagPayProtocol.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

public protocol BraspagPayProtocol {
    func makePayment(itemDescription: String, amount: Double)
    static func createInstance(currencyCode: String,
                               countryCode: String,
                               merchantId: String,
                               viewDelegate: BraspagViewControllerProtocol) -> BraspagPay
}
