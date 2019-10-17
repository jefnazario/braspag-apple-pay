//
//  AddressInfo.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 07/10/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

@objc public class AddressInfo: NSObject {
    var street, city, state, postalCode: String
    
    public init(street: String, city: String, state: String, postalCode: String) {
        self.street = street
        self.city = city
        self.state = state
        self.postalCode = postalCode
    }
}
