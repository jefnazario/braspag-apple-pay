//
//  AcceptedPaymentNetworks.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 14/10/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import PassKit

extension BraspagApplePay {
    @objc public func getAllowedPaymentNetwork() -> [PKPaymentNetwork] {
        return [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
    }
}
