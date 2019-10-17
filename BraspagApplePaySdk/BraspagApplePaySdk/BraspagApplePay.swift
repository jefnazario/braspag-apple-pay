//
//  EasyPay.swift
//  BraspagApplePaySdk
//
//  Created by Jeferson Nazario on 29/09/19.
//  Copyright © 2019 jnazario.com. All rights reserved.
//

import Foundation
import PassKit

@objc public class BraspagApplePay: NSObject, BraspagApplePayProtocol {

    var currencyCode, countryCode, merchantId: String!
    weak var delegate: BraspagApplePayViewControllerDelegate!
    
    @objc init(currencyCode: String = "BRL",
               countryCode: String = "BR",
               merchantId: String,
               delegate: BraspagApplePayViewControllerDelegate) {
        self.currencyCode = currencyCode
        self.countryCode = countryCode
        self.merchantId = merchantId
        self.delegate = delegate
    }
    
    public static func createInstance(merchantId: String,
                                      currencyCode: String = "BRL",
                                      countryCode: String = "BR",
                                      viewDelegate: BraspagApplePayViewControllerDelegate) -> BraspagApplePayProtocol {
        return BraspagApplePay(currencyCode: currencyCode,
                       countryCode: countryCode,
                       merchantId: merchantId,
                       delegate: viewDelegate)
    }
    
    @objc public func makePayment(itemDescription: String, amount: Double, contactInfo: ContactInfo? = nil) {
        let paymentItem = PKPaymentSummaryItem(label: itemDescription, amount: NSDecimalNumber(value: amount))
        let paymentNetworks = getAllowedPaymentNetwork()
        let requiredFields = Set<PKContactField>(arrayLiteral: PKContactField.name,
                                                 PKContactField.emailAddress,
                                                 PKContactField.postalAddress,
                                                 PKContactField.phoneNumber)
        
        guard PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) else {
            delegate.displayAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
            return
        }

        let request = PKPaymentRequest()
        request.currencyCode = currencyCode
        request.countryCode = countryCode
        request.merchantIdentifier = merchantId
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.supportedNetworks = paymentNetworks
        request.paymentSummaryItems = [paymentItem]
        
        if let contact = contactInfo {
            request.requiredBillingContactFields = requiredFields
            request.requiredShippingContactFields = requiredFields
            request.billingContact = createContactAddress(contactInfo: contact)
            request.shippingContact = createContactAddress(contactInfo: contact, isShippingAddress: true)
        }
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            delegate.displayAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
            return
        }
        paymentVC.delegate = self
        delegate.presentAuthorizationViewController(viewController: paymentVC)
    }
    
    fileprivate func createContact(contactInfo: ContactInfo) -> PKContact {
        var fullName = PersonNameComponents()
        fullName.givenName = contactInfo.firstname
        fullName.familyName = contactInfo.lastname
        
        let contact = PKContact()
        contact.name = fullName
        contact.emailAddress = contactInfo.email
        
        if let phone = contactInfo.phoneNumber {
            contact.phoneNumber = CNPhoneNumber(stringValue: phone)
        }
        
        return contact
    }
    
    fileprivate func createMutableAddress(addressInfo: AddressInfo) -> CNMutablePostalAddress {
        let address = CNMutablePostalAddress()
        address.street = addressInfo.street
        address.state = addressInfo.state
        address.city = addressInfo.city
        address.postalCode = addressInfo.postalCode
        
        return address
    }
    
    fileprivate func createContactAddress(contactInfo: ContactInfo, isShippingAddress: Bool = false) -> PKContact {
        let contact = createContact(contactInfo: contactInfo)
        
        guard let addressInfo = contactInfo.billingAddress else { return contact }
        contact.postalAddress = createMutableAddress(addressInfo: addressInfo)
        
        if isShippingAddress {
            guard let addressInfo = contactInfo.shippingAddress else { return contact }
            contact.postalAddress = createMutableAddress(addressInfo: addressInfo)
        }
        
        return contact
    }
}

extension BraspagApplePay: PKPaymentAuthorizationViewControllerDelegate {
    @objc public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        debugPrint(#function)
        delegate.dismissPaymentAuthorizationViewController()
    }
    
    @objc public func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        debugPrint(#function)
        delegate.dismissPaymentAuthorizationViewController()
        delegate.displayAlert(title: "Success!", message: "The Apple Pay transaction was complete.")
    }
}
