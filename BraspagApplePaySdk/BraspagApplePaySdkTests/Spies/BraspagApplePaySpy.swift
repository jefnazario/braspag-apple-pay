//
//  BraspagApplePaySpy.swift
//  BraspagApplePaySdkTests
//
//  Created by Jeferson Nazario on 14/10/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import XCTest
@testable import BraspagApplePaySdk

class BraspagApplePaySpy: BraspagApplePayProtocol {
    weak var delegate: BraspagApplePayViewControllerDelegate!
    
    var itemDescription: String = ""
    var amount: Double = 0
    var contactInfo: ContactInfo?
    
    init(currencyCode: String = "BRL",
         countryCode: String = "BR",
         merchantId: String,
         delegate: BraspagApplePayViewControllerDelegate) {
        
        self.delegate = delegate
    }
    
    func makePayment(itemDescription: String, amount: Double, contactInfo: ContactInfo?) {
        self.itemDescription = itemDescription
        self.amount = amount
        self.contactInfo = contactInfo
        let item = Products(rawValue: itemDescription) ?? .successfulWithoutContactInfo
        
        switch item {
        case .successfulWithoutContactInfo:
            delegate.presentAuthorizationViewController(viewController: UIViewController())
        
        case .forbiddenPaymentNetworks:
            delegate.displayAlert(title: "Error", message: "")
        
        case .allowedPaymentNetworks:
            delegate.presentAuthorizationViewController(viewController: UIViewController())
        }
    }
    
    static func createInstance(currencyCode: String,
                               countryCode: String,
                               merchantId: String,
                               viewDelegate: BraspagApplePayViewControllerDelegate) -> BraspagApplePayProtocol {
        return BraspagApplePaySpy(currencyCode: currencyCode,
                               countryCode: countryCode,
                               merchantId: merchantId,
                               delegate: viewDelegate)
    }
}
