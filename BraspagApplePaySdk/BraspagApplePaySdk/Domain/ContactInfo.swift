//
//  ContactInfo.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 07/10/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

@objc public class ContactInfo: NSObject {
    var firstname, lastname, email, phoneNumber: String?
    var billingAddress, shippingAddress: AddressInfo?
    
    public init(firstName: String,
                lastName: String,
                email: String,
                phoneNumber: String,
                billingAddress: AddressInfo? = nil,
                shippingAddress: AddressInfo? = nil) {
        
        self.firstname = firstName
        self.lastname = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.billingAddress = billingAddress
        self.shippingAddress = shippingAddress
    }
}
