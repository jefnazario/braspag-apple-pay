//
//  BraspagPayProtocol.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import PassKit

public protocol BraspagApplePayProtocol {
    func makePayment(itemDescription: String, amount: Double, contactInfo: ContactInfo?)
}
